package model;

public class AttributeList {

	private String attributeKey;
	private String attributeValue;
	
	public AttributeList() {
	}

	public AttributeList(String attributeKey, String attributeValue) {
		super();
		this.attributeKey = attributeKey;
		this.attributeValue = attributeValue;
	}

	public String getAttributeKey() {
		return attributeKey;
	}
	public void setAttributeKey(String attributeKey) {
		this.attributeKey = attributeKey;
	}
	public String getAttributeValue() {
		return attributeValue;
	}
	public void setAttributeValue(String attributeValue) {
		this.attributeValue = attributeValue;
	}
}
