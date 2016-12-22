SetAttribute() ::= <<
$preamble()$

package $package_reflect()$;

import java.util.Collection;

import $package()$.IfcBaseInterface;
import $package()$.SET;


public class SetAttribute extends DirectAttribute implements SetAccessor
{
	public SetAttribute(String name, Class<?> ownerType, boolean isDemandedOrOptional)
	{
		super(name, ownerType, isDemandedOrOptional);
		// TODO Auto-generated constructor stub
	}
	
	@Override
	public SET<IfcBaseInterface> get(Object ownerInstance)
	{
		return (SET<IfcBaseInterface>) super.get(ownerInstance);
	}

	@Override
	public Type getTypeCategory()
	{
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void set(Object ownerInstance, SET<IfcBaseInterface> value)
	{
		// TODO Auto-generated method stub

	}

	@Override
	public void add(Object ownerInstance, IfcBaseInterface element)
	{
		// TODO Auto-generated method stub

	}

	@Override
	public void addAll(Object ownerInstance, Collection<IfcBaseInterface> elements)
	{
		// TODO Auto-generated method stub

	}

	@Override
	public void remove(Object ownerInstance, IfcBaseInterface element)
	{
		// TODO Auto-generated method stub

	}

	@Override
	public void removeAll(Object ownerInstance, Collection<IfcBaseInterface> elements)
	{
		// TODO Auto-generated method stub

	}

	@Override
	public void clear(Object ownerInstance)
	{
		// TODO Auto-generated method stub

	}
}
>>