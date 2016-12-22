BAG() ::= <<
$preamble()$

package $package()$;

import java.util.Collection;
import java.util.Iterator;
import java.util.ArrayList;
import java.util.List;

import $package_reflect()$.Attribute;
import $package_reflect()$.DirectAttribute;


public class BAG<E extends IfcBaseInterface> extends ArrayList<E> implements IfcBaseInterface, AggregationType
{	
	public static final int UNDEFINED = -1;
	
	protected Attribute attribute; 
	protected IfcBase attributeOwner;
	protected final int loIndex;
	protected final int hiIndex;
	
	public BAG()
	{
		super();
		this.loIndex = UNDEFINED;
		this.hiIndex = UNDEFINED;
	}

	public BAG(List<E> list)
	{
		super(list);
		this.loIndex = UNDEFINED;
		this.hiIndex = UNDEFINED;
	}
	
	public BAG(Collection<E> value)
	{
		this(value, UNDEFINED, UNDEFINED);
	}
	
	public BAG(Collection<E> value, int hiIndex)
	{
		this(value, UNDEFINED, hiIndex);
	}
	
	public BAG(Collection<E> value, int loIndex, int hiIndex)
	{
		super(value);
		this.loIndex = loIndex;
		this.hiIndex = hiIndex;
	}
	
	public int getLoIndex()
	{
		return this.loIndex;
	}
	
	public int getHiIndex()
	{
		return this.hiIndex;
	}
	
	/** 
	 * For internal use only
	 * 
	 */
	@Override
	public void attach(IfcBase attributeOwner, Attribute attribute)
	{		
		this.attributeOwner = attributeOwner;
		this.attribute = attribute;
	}
	
	/** 
	 * For internal use only
	 * 
	 */
	@Override
	public void detach()
	{		
		this.attributeOwner = null;
		this.attribute = null;
	}
	
	@Override
	public boolean isAttached()
	{
		return this.attributeOwner != null && this.attribute != null;
	}
	
	/*@Override
	public boolean add(E e)
	{
		if (e == null)
			throw new NullPointerException();
		
		if (!contains(e) && this.hiIndex < this.size())
		{
			Set<E> old = new HashSet<E>(this);			
			
			boolean result = super.add(e);
			if (result)
			{
				boolean sync = isAttached() && this.attribute instanceof DirectAttribute;
				boolean fire = sync;
				if (sync)
					((DirectAttribute) this.attribute).syncInversesAdd(this.attributeOwner, e);				
				if (fire)
					this.attributeOwner.fireChangeEvent((DirectAttribute) this.attribute, old, this);
			}
			return result;
		}
		return false;
	}

	@Override
	public boolean addAll(Collection<? extends E> c)
	{
		for (E e : c)
		{
			if (e == null)
				throw new NullPointerException();
		}
		
		Set<E> old = new HashSet<E>(this);		
		
		boolean result = super.addAll(c);		
		if (result)
		{
			boolean sync = isAttached() && this.attribute instanceof DirectAttribute;
			boolean fire = sync;
			if (sync)
				((DirectAttribute) this.attribute).syncInversesAddAll(this.attributeOwner, (Collection<IfcBaseInterface>) c);
			if (fire)
				this.attributeOwner.fireChangeEvent((DirectAttribute) this.attribute, old, this);
		}
		
		return result;
	}
	
	@Override
	public boolean remove(Object o)
	{
		Set<E> old = new HashSet<E>(this);
						
		boolean result = false;
		
		result = super.remove(o);
		if (result)
		{
			boolean sync = isAttached() && this.attribute instanceof DirectAttribute;
			boolean fire = sync;
			if (sync)
				((DirectAttribute) this.attribute).syncInversesRemove(this.attributeOwner, (IfcBaseInterface) o);
			if (fire)
				this.attributeOwner.fireChangeEvent((DirectAttribute) this.attribute, old, this);
		}
		
		return result;
	}
	
	@Override
	public boolean removeAll(Collection<?> c)
	{
		Set<E> old = new HashSet<E>(this);
				
		boolean result = super.removeAll(c);		
		if (result)
		{
			boolean sync = isAttached() && this.attribute instanceof DirectAttribute;
			boolean fire = sync;			
			if (sync)
				((DirectAttribute) this.attribute).syncInversesRemoveAll(this.attributeOwner, (Collection<IfcBaseInterface>) c);
			if (fire)
				this.attributeOwner.fireChangeEvent((DirectAttribute) this.attribute, old, this);
		}
		
		return result;
	}

	@Override
	public boolean retainAll(Collection<?> c)
	{
		Set<E> old = new HashSet<E>(this);
		
		Set<E> difference = new HashSet<E>(this);
		difference.removeAll(c);
		
		boolean result = super.retainAll(c);		
		if (result)
		{
			boolean sync = isAttached() && this.attribute instanceof DirectAttribute;
			boolean fire = sync;
			if (sync)
				((DirectAttribute) this.attribute).syncInversesRemoveAll(this.attributeOwner, (Collection<IfcBaseInterface>) difference);
			if (fire)
				this.attributeOwner.fireChangeEvent((DirectAttribute) this.attribute, old, this);
		}
		
		return result;
	}

	@Override
	public void clear()
	{
		Set<E> old = new HashSet<E>(this);
		
		super.clear();
		
		boolean sync = isAttached() && this.attribute instanceof DirectAttribute;
		boolean fire = sync;
		if (sync)			
			((DirectAttribute) this.attribute).syncInversesRemoveAll(this.attributeOwner, (Collection<IfcBaseInterface>) old);
		if (fire)
		this.attributeOwner.fireChangeEvent((DirectAttribute) this.attribute, old, this);
	}*/

	@SuppressWarnings("unchecked")
	@Override
	public BAG<E> clone() 
	{
		BAG<E> clone = new BAG<E>();
		for (DeepCloneable e : this)
			clone.add((E) e.clone());
		
		//clone.attribute = this.attribute;
		//clone.attributeOwner = this.attributeOwner;
		
		return clone;
	}
	
	public BAG<E> shallowClone() 
	{
		BAG<E> clone = new BAG<E>();
		for (E e : this)
			clone.add(e);
		return clone;
	}
	
	@Override
	public String toString() 
	{
		StringBuilder strBuilder = new StringBuilder("[");
		int i = 0;
		Iterator<E> iterator = this.iterator();
		while (iterator.hasNext()) 
		{
			E object = iterator.next();
			strBuilder.append(object.toString());
			if (i++ != this.size() - 1) 
				strBuilder.append(",");
		}
		strBuilder.append("]");
		return strBuilder.toString();
	}
}
>>