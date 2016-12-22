BINARY() ::= <<
$preamble()$

package $package()$;


public class BINARY implements IfcBaseInterface
{
	/**
	 * The value
	 */
	private java.util.BitSet value = new java.util.BitSet();

	/**
	 * Constructs a new BINARY object. The default value is unknown
	 */
	public BINARY()
	{
	}

	/**
	 * This method sets the value of this object.
	 * @param value
	 *            the value to set
	 */
	public void setValue(java.util.BitSet value) 
	{
		this.value = value;
	}

	/**
	 * This method sets the value of this object.
	 * @param value
	 *            the value to set
	 */
	public void setValue(BINARY value) 
	{
		this.value = value.value;
	}

	/**
	 * This method is used internally and should NOT be used for own purposes.
	 **/
	public String getStepParameter(boolean isSelectType) 
	{
		throw new java.lang.UnsupportedOperationException();
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
	public BINARY clone() 
	{
		BINARY clone = new BINARY();
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
		return this.value.toString();
	}
}
>>