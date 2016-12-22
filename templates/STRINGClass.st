STRINGClass(declType, primitiveType, wrapperType) ::= <<
$preamble()$

package $package()$;


public $class(declType)$ $extends(declType)$$implements_(declType, "Type")$
{
	public static $declType.id$ empty()
	{
		return new $declType.id$("", true);
	}
	
	public $declType.id$()
	{		
	}
	
	public $declType.id$($declType.superType.type.id$ other)
	{
		setValue(other);
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
	public $declType.id$(String value, boolean isDecoded)
	{
		super(value, isDecoded);
	}
	
	public void setValue(Object other) 
	{
		super.setValue((STRING) other);
	}
	
	@Override	
	public $declType.id$ clone()
	{
		$declType.id$ clone = ($declType.id$) super.clone();
		
		return clone;
	}
	
	public $declType.id$ shallowClone()
	{
		$declType.id$ clone = ($declType.id$) super.clone();

		return clone;
	}
}
>>