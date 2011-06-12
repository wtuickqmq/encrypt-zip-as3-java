package com.training.demo.model.vo;

public class HashData {

	private byte[] zipByte = null;
	private byte[] mdByte = null;
	private String md = "";
	private String hashType = "";


	public HashData() {
	}

	public byte[] getZipByte() {
		return zipByte;
	}

	public void setZipByte(byte[] zipByte) {
		this.zipByte = zipByte;
	}
    
	public byte[] getMdByte() {
		return mdByte;
	}

	public void setMdByte(byte[] mdByte) {
		this.mdByte = mdByte;
	}

	public String getMd() {
		return md;
	}

	public void setMd(String md) {
		this.md = md;
	}

	public String getHashType() {
		return hashType;
	}

	public void setHashType(String hashType) {
		this.hashType = hashType;
	}

}
