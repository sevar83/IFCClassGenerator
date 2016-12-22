SIMPLETYPEClass(declType, primitiveType, wrapperType) ::= <<
$preamble()$

package $package()$;


public $class(declType)$ $extends(declType)$$implements_(declType, "Type")$
{
	public $declType.id$()
	{		
	}
	
	public $declType.id$($declType.superType.type.id$ other)
	{
		setValue(other);
	}
	
	public $declType.id$($primitiveType$ value)
	{
		super.setValue(value);
	}
	
	public void setValue(Object other) 
	{
		super.setValue(($declType.superType.type.id$) other);
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