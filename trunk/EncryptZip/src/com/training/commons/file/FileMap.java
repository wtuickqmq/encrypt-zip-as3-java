package com.training.commons.file;

public class FileMap {

	private String fileName = "";
	private java.lang.Long fileSize;
	private byte[] fileData = null;
	private String status = "";

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public java.lang.Long getFileSize() {
		return fileSize;
	}

	public void setFileSize(java.lang.Long fileSize) {
		this.fileSize = fileSize;
	}

	public byte[] getFileData() {
		return fileData;
	}

	public void setFileData(byte[] fileData) {
		this.fileData = fileData;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}
