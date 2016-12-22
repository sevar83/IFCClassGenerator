SetAccessor() ::= <<
$preamble()$

package $package_reflect()$;

import java.util.Collection;

import $package()$.IfcBaseInterface;
import $package()$.SET;


public interface SetAccessor extends AggregationAttribute
{
	public SET<IfcBaseInterface> get(Object ownerInstance);
	public void set(Object ownerInstance, SET<IfcBaseInterface> value);
	
	public void add(Object ownerInstance, IfcBaseInterface element);
	public void addAll(Object ownerInstance, Collection<IfcBaseInterface> elements);
	public void remove(Object ownerInstance, IfcBaseInterface element);
	public void removeAll(Object ownerInstance, Collection<IfcBaseInterface> elements);
	public void clear(Object ownerInstance);
}
>>