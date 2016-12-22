ARRAY() ::= <<
$preamble()$

package $package()$;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;


public class ARRAY<E extends DeepCloneable> extends ArrayList<E> implements IfcBaseInterface
{
	public ARRAY()
	{
		super();
	}

	public ARRAY(Collection<E> value)
	{
		super(value);
	}
	
	public void setValue(ARRAY<E> value) 
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
	public ARRAY<E> clone() 
	{
		ARRAY<E> list = new ARRAY<E>();
		for (DeepCloneable e : this)
			list.add((E) e.clone());
		return list;
	}
	
	public ARRAY<E> shallowClone() 
	{
		ARRAY<E> list = new ARRAY<E>();
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