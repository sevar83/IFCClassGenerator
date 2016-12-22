INTEGER() ::= <<
$preamble()$

package $package()$;

public class INTEGER implements IfcBaseInterface
{
	/**
	 * the value
	 */
	public int value;

	/**
	 * Constructs a new INTEGER object. The default value is zero.
	 */
	public INTEGER()
	{
	}

	/**
	 * Constructs a new INTEGER object using the given value.
	 * @param value
	 *            the value
	 */
	public INTEGER(int value)
	{
		this.value = value;
	}

	/**
	 * This method sets the value of this object.
	 * @param value
	 *            the value to set
	 */
	public void setValue(int value) 
	{
		this.value = value;
	}

	/**
	 * This method sets the value of this object.
	 * @param value
	 *            the value to set
	 */
	public void setValue(INTEGER value) 
	{
		this.value = value.value;
	}

	/**
	 * This method is used internally and should NOT be used for own purposes.
	 **/
	public String getStepParameter(boolean isSelectType) 
	{
		return String.valueOf(this.value);
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
	public Object clone() 
	{
		INTEGER integer = new INTEGER(this.value);
		return integer;
	}

	/**
	 * This method returns the objects value as String representation.
	 * @return the value as String representation
	 */
	public String toString() 
	{
		return Integer.toString(this.value);
	}
}
>>