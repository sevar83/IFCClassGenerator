LOGICAL() ::= <<
$preamble()$

package $package()$;


public class LOGICAL implements IfcBaseInterface
{
	/**
	 * the value - true, false, null if unknown
	 */
	public Boolean value = null;

	/**
	 * Constructs a new LOGICAL object. The default value is unknown
	 */
	public LOGICAL()
	{
	}

	public LOGICAL(Boolean value)
	{
		this.value = value;
	}
	
	/**
	 * Constructs a new BYTE object using the given value.
	 * @param value the value
	 */
	public LOGICAL(String value)
	{
		if ("T".equals(value.toUpperCase())) 
			this.value = new Boolean(true);
		else if ("F".equals(value.toUpperCase())) 
			this.value = new Boolean(false);
	}

	/**
	 * This method sets the value of this object.
	 * @param value
	 *            the value to set
	 */
	public void setValue(Boolean value) 
	{
		this.value = value;
	}

	/**
	 * This method sets the value of this object.
	 * @param value
	 *            the value to set
	 */
	public void setValue(LOGICAL value) 
	{
		this.value = value.value;
	}

	/**
	 * This method is used internally and should NOT be used for own purposes.
	 **/
	public String getStepParameter(boolean isSelectType) 
	{
		if (this.value == null) 
			return ".U.";
		if (this.value == false) 
			return ".F.";
		return ".T.";
	}

	/**
	 * This method has no use for simple types.
	 * @return null
	 **/
	public String getStepLine() 
	{
		return null;
	}

	/**
	 * This method clones the object (deep cloning).
	 * @return the cloned object
	 **/
	@Override
	public LOGICAL clone() 
	{
		LOGICAL logical = new LOGICAL();
		logical.setValue(this.value);
		
		return logical;
	}

	/**
	 * This method returns the objects value as String representation.
	 * @return the value as String representation
	 */
	@Override
	public String toString() 
	{
		if (this.value == null) 
			return "unknown";
		else
			return Boolean.toString(this.value);
	}
}
>>