BOOLEAN() ::= <<
$preamble()$

package $package()$;


public class BOOLEAN implements IfcBaseInterface
{
	/**
	 * The value
	 */
	public boolean value = false;

	/**
	 * Constructs a new BOOLEAN object. The default value is unknown
	 */
	public BOOLEAN()
	{
	}
	
	public BOOLEAN(boolean value)
	{
		this.value = value;
	}

	/**
	 * Constructs a new BOOLEAN object using the given value.
	 * @param value the value
	 */
	public BOOLEAN(String value)
	{
		if ("T".equals(value.toUpperCase())) 
			this.value = new Boolean(true);
		else
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
	public void setValue(BOOLEAN value) 
	{
		this.value = value.value;
	}

	/**
	 * This method is used internally and should NOT be used for own purposes.
	 **/
	public String getStepParameter(boolean isSelectType) 
	{
		if (this.value == false) 
			return ".F.";
		else
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
	public BOOLEAN clone() 
	{
		BOOLEAN clone = new BOOLEAN();
		clone.setValue(this.value);
		
		return clone;
	}

	/**
	 * This method returns the objects value as String representation.
	 * @return the value as String representation
	 */
	@Override
	public String toString() 
	{
		return Boolean.toString(this.value);
	}
}
>>