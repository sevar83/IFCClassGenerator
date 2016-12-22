STRING() ::= <<
$preamble()$

package $package()$;

import java.nio.charset.CharacterCodingException;


public class STRING implements IfcBaseInterface
{
	public static STRING empty()
	{
		return new STRING("", true);
	}
	
	/**
	 * The value will be stored as decoded String object.
	 */
	protected String value = null;

	/**
	 * Constructs a new STRING object. The default value is "".
	 */
	public STRING()
	{
		value = new String();
	}

	/**
	 * Constructs a new STRING object by copying the given value.
	 * @param value
	 *            STRING object to copy
	 */
	public STRING(STRING value)
	{
		if (value != null)
			this.value = new String(value.getDecodedValue());	// SV
	}

	/**
	 * Constructs a new STRING object using the given value. The value will be
	 * either decoded or not decoded depending on the second boolean parameter
	 * isDecoded.
	 * @param value
	 *            the value
	 * @param isDecoded
	 *            set to true, if the given value is already decoded like "T?r"
	 *            set to false, if the given value has to be decoded according
	 *            to ISO-10303-21 (§6.3.3.1-§6.3.3.3) like "T\S\|r"
	 */
	public STRING(String value, boolean isDecoded)
	{
		if (value == null)
			return;		
		
		if (!isDecoded) 
		{
			try 
			{
				this.value = new String(StringConverter.decode(value));
			}
			catch (CharacterCodingException e)
			{
				this.value = new String(value);
			}
		} 
		else 
		{
			this.value = new String(value);
		}
	}

	/**
	 * This method sets the value of this object.
	 * @param value
	 *            the value to set
	 */
	public void setValue(STRING value) 
	{
		this.value = (value != null) ? new String(value.getDecodedValue()) : null;
	}

	/**
	 * This method sets the value of this object. The given value has to be
	 * decoded according to ISO-10303-21(§6.3.3.1-§6.3.3.3). The value will be
	 * internally decoded according to ISO-10303-21(§6.3.3.1-§6.3.3.3) "T\S\|r"
	 * -> "T?r" - if the value could not be decoded for any reason, the input
	 * value will be distinguished as already decoded.
	 * @param value
	 *            the value to set
	 */
	public void setEncodedValue(String value) 
	{
		if (value == null)
			this.value = null;
		
		try 
		{
			this.value = new String(StringConverter.decode(value));
		}
		catch (CharacterCodingException e) 
		{
			// if the string could not be decoded use the input value
			this.value = new String(value);
		}
	}

	/**
	 * This method sets the value of this object. The value will not be decoded.
	 * @param value
	 *            the value to set
	 */
	public void setDecodedValue(String value) 
	{
		this.value = new String(value);
	}

	/**
	 * This method returns the value of this object as encoded and limited to
	 * maximum length of 32767 charactersString according to
	 * ISO-10303-21(§6.3.3.1-§6.3.3.3) - "T?r" -> "T\s\|r". Longer Strings will
	 * be cut after the 32767th character.
	 * @return the value as decoded String
	 */
	public String getEncodedValue() 
	{
		// Maximum length is 32767 characters (according to ISO 10303-21
		// 6.3.3.4).
		// Longer strings will be cut
		if (this.value == null) return "''";
		else if (value.length() > (32767)) return "'"
				+ StringConverter.autoencode(value.substring(0, 32767)) + "'";
		else
			return "'" + StringConverter.autoencode(this.value) + "'";
	}

	/**
	 * This method returns the value of this object as decoded String according
	 * to ISO-10303-21(§6.3.3.1-§6.3.3.3) - "T?r" -> "T\s\|r".
	 * @return the decoded value
	 */
	public String getDecodedValue() 
	{
		return this.value;
	}

	/**
	 * This method is used internally and should NOT be used for own purposes.
	 **/
	public String getStepParameter(boolean isSelectType) 
	{
		// Maximum length is 32767 characters (according to ISO 10303-21
		// 6.3.3.4).
		// Longer strings will be cut
		if (this.value == null) return "''";
		else if (value.length() > (32767)) return "'"
				+ StringConverter.autoencode(value.substring(0, 32767)) + "'";
		else
			return "'" + StringConverter.autoencode(this.value) + "'";
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
		STRING string = new STRING(this);
		return string;
	}

	/**
	 * This method returns the objects value as String representation.
	 * @return the value as String representation
	 */
	public String toString()
	{
		return this.value;
	}
}
>>