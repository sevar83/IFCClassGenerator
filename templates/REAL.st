REAL() ::= <<
$preamble()$

package $package()$;

public class REAL implements IfcBaseInterface
{
	public float value;

	/**
	 * Constructs a new REAL object. The default value is zero.
	 */
	public REAL()
	{
	}

	/**
	 * Constructs a new REAL object using the given value.
	 * @param value
	 *            the value
	 */
	public REAL(float value)
	{
		this.value = value;
	}

	/**
	 * This method sets the value of this object.
	 * @param value
	 *            the value to set
	 */
	public void setValue(float value) 
	{
		this.value = value;
	}

	/**
	 * This method sets the value of this object.
	 * @param value
	 *            the value to set
	 */
	public void setValue(REAL value) 
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
		REAL clone = new REAL(this.value);
		return clone;
	}

	/**
	 * This method returns the objects value as String representation.
	 * @return the value as String representation
	 */
	public String toString() 
	{
		return Float.toString(this.value);
	}
}
>>