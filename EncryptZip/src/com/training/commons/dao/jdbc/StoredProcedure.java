package com.training.commons.dao.jdbc;

import org.springframework.jdbc.core.support.JdbcDaoSupport;
import org.springframework.jdbc.core.CallableStatementCallback;
import org.springframework.dao.DataAccessException;
import org.springframework.core.CollectionFactory;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import java.util.Collection;
import java.sql.*; 
public class StoredProcedure extends JdbcDaoSupport {
    private String procedureName;

    public List getSqlvalues() {
        return sqlvalues;
    }

    public void setSqlvalues(List sqlvalues) {
        this.sqlvalues = sqlvalues;
    }

    private List sqlvalues;

    public String getProcedureName() {
        return procedureName;
    }

    public void setProcedureName(String procedureName) {
        this.procedureName = procedureName;
    }

    public List execute() {
        final ArrayList list = new ArrayList();
        Object o = getJdbcTemplate().execute(genSqlStrig(), new CallableStatementCallback() {
            public Object doInCallableStatement(CallableStatement arg0) throws SQLException, DataAccessException {
                arg0.registerOutParameter(1, Types.INTEGER);
                for (int i = 0; i < sqlvalues.size(); i++) {
                    arg0.setObject(i + 2, sqlvalues.get(i));
                }
                ResultSet rs = arg0.executeQuery();
                ListResultSetExtractor ls = new ListResultSetExtractor();
                list.addAll((Collection) ls.extractData(rs));
                return null;
            }

        });
        return list;
    }

    private String genSqlStrig() {
        StringBuffer sb = new StringBuffer();
        sb.append("{?= call ");
        sb.append(procedureName);
        sb.append("( ");
        if (sqlvalues != null && sqlvalues.size() > 0) {
            for (int i = 0; i < sqlvalues.size(); i++) {
                if (i == sqlvalues.size() - 1) {
                    sb.append("?");
                } else {
                    sb.append("?");
                }
            }


        }
        sb.append(")}");
        return sb.toString();
    }

    private static class ListResultSetExtractor  {

        public Object extractData(ResultSet rs) throws SQLException {
            List listOfRows = new ArrayList();
            ResultSetMetaData rsmd = null;
            int numberOfColumns = -1;
            while (rs.next()) {
                if (rsmd == null) {
                    rsmd = rs.getMetaData();
                    numberOfColumns = rsmd.getColumnCount();
                }
                Map mapOfColValues = CollectionFactory.createLinkedMapIfPossible(numberOfColumns);
                for (int i = 1; i <= numberOfColumns; i++) {
                    switch (rsmd.getColumnType(i)) {
                        case java.sql.Types.TIMESTAMP:
                            mapOfColValues.put(rsmd.getColumnName(i), rs.getTimestamp(i));
                            break;
                        default:
                            mapOfColValues.put(rsmd.getColumnName(i), rs.getObject(i));
                    }
                }
                listOfRows.add(mapOfColValues);
            }
            return listOfRows;
        }
    }
}