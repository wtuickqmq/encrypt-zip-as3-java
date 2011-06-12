package com.training.commons.file;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;
import java.util.zip.ZipEntry;


/**
 * ZIP 数据处理工具
 */
public final class ZipUtils {

	public static final byte[] MAGIC_NUMBER = { 0x50, 0x4B, 0x03, 0x04 };

	private ZipUtils() {

	}

	public static boolean isZipFile(byte[] rawZipFile) {
		if (rawZipFile.length < MAGIC_NUMBER.length) {
			return false;
		}
		for (int i = 0; i < MAGIC_NUMBER.length; i++) {
			if (MAGIC_NUMBER[i] != rawZipFile[i]) {
				return false;
			}
		}
		return true;
	}

	public static byte[] toRawZipFile(List<ZipEntry> entries, List<byte[]> files)
			throws java.io.IOException {

		if (entries.size() != files.size()) {
			return null;
		}
		ByteArrayOutputStream bytes = new ByteArrayOutputStream();
		ZipOutputStream zip = new ZipOutputStream(bytes);
		Iterator<ZipEntry> entriesItr = entries.iterator();
		Iterator<byte[]> filesItr = files.iterator();
		while (entriesItr.hasNext()) {
			byte[] file = filesItr.next();
			ZipEntry entry = entriesItr.next();
			zip.putNextEntry(entry);
			zip.write(file, 0, file.length);
		}
		zip.close();
		return bytes.toByteArray();
	}

	public static List<ZipEntry> toZipEntryList(byte[] rawZipFile)
			throws java.io.IOException {
		ArrayList<ZipEntry> entries = new ArrayList<ZipEntry>();
		ByteArrayInputStream bytes = new ByteArrayInputStream(rawZipFile);
		ZipInputStream zip = new ZipInputStream(bytes);
		ZipEntry entry = zip.getNextEntry();
		while (entry != null) {
			entries.add(entry);
			entry = zip.getNextEntry();
		}
		zip.close();
		return entries;
	}

	public static List<byte[]> toByteArrayList(byte[] rawZipFile)
			throws java.io.IOException {
		ArrayList<byte[]> files = new ArrayList<byte[]>();
		ByteArrayInputStream bytes = new ByteArrayInputStream(rawZipFile);
		ZipInputStream zip = new ZipInputStream(bytes);
		int len;
		ByteArrayOutputStream file;
		ZipEntry entry = zip.getNextEntry();
		while (entry != null) {
			file = new ByteArrayOutputStream();
			byte[] buf = new byte[4096];
			while ((len = zip.read(buf, 0, 4096)) != -1) {
				file.write(buf, 0, len);
			}
			files.add(file.toByteArray());
			entry = zip.getNextEntry();
		}
		zip.close();
		return files;
	}

	public static byte[] readZipByte(File[] srcfile) {
		ByteArrayOutputStream tempOStream = new ByteArrayOutputStream(1024);
		byte[] tempBytes = null;
		byte[] buf = new byte[1024];
		try {
			ZipOutputStream out = new ZipOutputStream(tempOStream);
			for (int i = 0; i < srcfile.length; i++) {
				FileInputStream in = new FileInputStream(srcfile[i]);
				out.putNextEntry(new ZipEntry(srcfile[i].getName()));
				int len;
				while ((len = in.read(buf)) > 0) {
					out.write(buf, 0, len);
				}
				out.closeEntry();
				in.close();
			}
			tempOStream.flush();
			out.close();
			tempBytes = tempOStream.toByteArray();
			tempOStream.close();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return tempBytes;
	}
//	public static DataHandler readZipDataHandler(File[] srcfile) throws Exception {
//		ByteArrayOutputStream tempOStream = new ByteArrayOutputStream(1024);
//		byte[] tempBytes = null;
//		byte[] buf = new byte[1024];
//			ZipOutputStream out = new ZipOutputStream(tempOStream);
//			for (int i = 0; i < srcfile.length; i++) {
//				FileInputStream in = new FileInputStream(srcfile[i]);
//				out.putNextEntry(new ZipEntry(srcfile[i].getName()));
//				int len;
//				while ((len = in.read(buf)) > 0) {
//					out.write(buf, 0, len);
//				}
//				out.closeEntry();
//				in.close();
//			}
//			tempOStream.flush();
//			tempBytes = tempOStream.toByteArray();
//			
//			out.close();
//			tempOStream.close();
//			DataHandler handler = new DataHandler(new ByteArrayDataSource(tempBytes, "application/octet-stream"));
//		return handler;
//	}
	
	public static byte[] zipFiles(Map<String, byte[]> files) throws Exception {
		ByteArrayOutputStream dest = new ByteArrayOutputStream();
		ZipOutputStream out = new ZipOutputStream(
				new BufferedOutputStream(dest));
		byte[] data = new byte[2048];
		Iterator<String> itr = files.keySet().iterator();
		while (itr.hasNext()) {
			String tempName = itr.next();
			byte[] tempFile = files.get(tempName);

			ByteArrayInputStream bytesIn = new ByteArrayInputStream(tempFile);
			BufferedInputStream origin = new BufferedInputStream(bytesIn, 2048);
			ZipEntry entry = new ZipEntry(tempName);
			out.putNextEntry(entry);
			int count;
			while ((count = origin.read(data, 0, 2048)) != -1) {
				out.write(data, 0, count);
			}
			bytesIn.close();
			origin.close();
		}
		out.close();
		byte[] outBytes = dest.toByteArray();
		dest.close();
		return outBytes;
	}

	public static byte[] zipEntriesAndFiles(Map<ZipEntry, byte[]> files)
			throws Exception {
		ByteArrayOutputStream dest = new ByteArrayOutputStream();
		ZipOutputStream out = new ZipOutputStream(
				new BufferedOutputStream(dest));
		byte[] data = new byte[2048];
		Iterator<ZipEntry> itr = files.keySet().iterator();
		while (itr.hasNext()) {
			ZipEntry entry = itr.next();
			byte[] tempFile = files.get(entry);
			ByteArrayInputStream bytesIn = new ByteArrayInputStream(tempFile);
			BufferedInputStream origin = new BufferedInputStream(bytesIn, 2048);
			out.putNextEntry(entry);
			int count;
			while ((count = origin.read(data, 0, 2048)) != -1) {
				out.write(data, 0, count);
			}
			bytesIn.close();
			origin.close();
		}
		out.close();
		byte[] outBytes = dest.toByteArray();
		dest.close();
		return outBytes;

	}

	public static Map<String, byte[]> unzipFiles(byte[] zipBytes)
			throws IOException {
		InputStream bais = new ByteArrayInputStream(zipBytes);
		ZipInputStream zin = new ZipInputStream(bais);
		ZipEntry ze;
		Map<String, byte[]> extractedFiles = new HashMap<String, byte[]>();
		while ((ze = zin.getNextEntry()) != null) {
			ByteArrayOutputStream toScan = new ByteArrayOutputStream();
			byte[] buf = new byte[1024];
			int len;
			while ((len = zin.read(buf)) > 0) {
				toScan.write(buf, 0, len);
			}
			byte[] fileOut = toScan.toByteArray();
			toScan.close();
			extractedFiles.put(ze.getName(), fileOut);
		}
		zin.close();
		bais.close();
		return extractedFiles;
	}

	public static Map<String, byte[]> unzipFiles(InputStream bais)
			throws IOException {
		ZipInputStream zin = new ZipInputStream(bais);
		ZipEntry ze;
		Map<String, byte[]> extractedFiles = new HashMap<String, byte[]>();
		while ((ze = zin.getNextEntry()) != null) {
			ByteArrayOutputStream toScan = new ByteArrayOutputStream();
			byte[] buf = new byte[1024];
			int len;
			while ((len = zin.read(buf)) > 0) {
				toScan.write(buf, 0, len);
			}
			byte[] fileOut = toScan.toByteArray();
			toScan.close();
			extractedFiles.put(ze.getName(), fileOut);
		}
		zin.close();
		bais.close();
		return extractedFiles;
	}

}
