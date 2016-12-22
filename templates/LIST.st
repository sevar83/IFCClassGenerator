LIST() ::= <<
$preamble()$

package $package()$;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;


public class LIST<E extends DeepCloneable> extends ArrayList<E> implements IfcBaseInterface
{
	public LIST()
	{
		super();
	}

	public LIST(Collection<E> value)
	{
		super(value);
	}
	
	public void setValue(LIST<E> value) 
	{
		super.clear();
		super.addAll(value);
	}
	
	public E getFirst()
	{
		Iterator<E> it = iterator();
		if (it != null && it.hasNext())
			return it.next();
		return null;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public LIST<E> clone() 
	{
		LIST<E> list = new LIST<E>();
		for (DeepCloneable e : this)
			list.add((E) e.clone());
		return list;
	}
	
	public LIST<E> shallowClone() 
	{
		LIST<E> list = new LIST<E>();
		for (E e : this)
			list.add(e);
		return list;
	}
	
	@Override
	public String toString() 
	{
		StringBuilder strBuilder = new StringBuilder("[");
		for (int i = 0; i < this.size(); i++) 
		{
			strBuilder.append(get(i).toString());
			if (i != this.size() - 1) 
				strBuilder.append(get(i).toString() + ",");
		}
		strBuilder.append("]");
		return strBuilder.toString();
	}
}
>>