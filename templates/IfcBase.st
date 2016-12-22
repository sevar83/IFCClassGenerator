IfcBase() ::= <<
$preamble()$

package $package()$;

import static $package_tools()$.predicates.Predicates.instanceOf;

import java.beans.PropertyChangeListener;
import java.util.Collection;

import $package_reflect()$.Attribute;
import $package_reflect()$.DirectAttribute;
import $package_reflect()$.InverseAttribute;
import $package_reflect()$.AggregationAttribute;


public abstract class IfcBase implements IfcClass, IfcBaseInterface
{
	private transient IfcClassSupport ifcClassSupport = null;
	
	public IfcBase()
	{
	}
	
	/**
	 * Universal Initializer
	 * 
	 * @param parameters values for all attributes. The optional attributes could be null. Demanded must be non-null
	 */
	protected void classInitializeAttributes(Class<?> type, Object ... parameters)
	{
		Collection<Attribute> directAttributes = Attribute.find(type, instanceOf(DirectAttribute.class));
						
		String msgPrefix = "classInitializeAttributes(): ";
		
		if (parameters.length == 0 && directAttributes != null && directAttributes.size() > 0)
		{
			throw new IllegalStateException(msgPrefix + "Zero parameters in varargs. Must supply " + directAttributes.size() + " parameters");
		}
		else if (parameters.length > 0 && (directAttributes == null || directAttributes.size() == 0))
		{
			throw new IllegalStateException(msgPrefix + "Parameters are supplied, but no direct attributes are found for type " + type.getSimpleName());
		}
		else if (parameters.length > 0 && directAttributes != null)
		{
			// Size match check
			if (parameters.length != directAttributes.size())
				throw new IllegalStateException(msgPrefix + "Parameter count does not match the count of direct attributes of type " + type.getSimpleName());
		
			int i = 0;
			for (Attribute attribute : directAttributes)
			{
				// Null check
				if (parameters[i] == null)
				{
					if (attribute.isDemanded())
						throw new NullPointerException(msgPrefix + "The demanded parameter \"" + attribute.getName() + "\" must be non-null");
					else
						continue;
				}
				
				// Type check
				if (!attribute.getType().isAssignableFrom(parameters[i].getClass()))
					throw new IllegalStateException(msgPrefix + "The parameter for \"" + attribute.getName() + "\" does not match the attribute's type: " + attribute.getType());
					
				//((DirectAttribute) attribute).set(this, parameters[i]);
				// Temporarily suppress event firing?
				setAttributeValue((DirectAttribute) attribute, parameters[i]);
				
				i++;
			}
		}
	}
		
	protected Object getAttributeValue(Attribute attribute)
	{
		return attribute.get(this);
	}
	
	// TODO: Temporary lock on firing events? As a boolean parameter?
	protected void setAttributeValue(DirectAttribute attribute, Object value)
	{
		Object oldValue = attribute.get(this);
		if (oldValue != null && !oldValue.equals(value) ||
				value != null && !value.equals(oldValue))
		{
			// Check if the it is an aggregate object already attached to an attribute
			if (value instanceof AggregationType)
			{				
				AggregationType agg = (AggregationType) value;
				if (agg.isAttached())
					throw new IllegalArgumentException("The aggregate value is already attached to an attribute. It must be either detached or cloned first");
			}			
			
			if (oldValue instanceof AggregationType)
			{
				AggregationType agg = (AggregationType) value;
				if (agg.isAttached())
					agg.detach();
			}
			
			if (value instanceof AggregationType)
			{				
				AggregationType agg = (AggregationType) value;				
				agg.attach(this, attribute);
			}
			
			attribute.set(this, value);
			fireChangeEvent(attribute, oldValue, value);
		}
	}
	
	@Override
	public void addPropertyChangeListener(PropertyChangeListener listener)
	{
		if (this.ifcClassSupport == null)
			this.ifcClassSupport = new IfcClassSupport(this);
		this.ifcClassSupport.addObjectChangeListener(listener);
	}

	@Override
	public void removePropertyChangeListener(PropertyChangeListener listener)
	{
		if (this.ifcClassSupport != null)
			this.ifcClassSupport.removeObjectChangeListener(listener);
	}

	//@Override
	public void removeAllObjectChangeListeners()
	{
		if (this.ifcClassSupport != null)
			this.ifcClassSupport.removeAllPropertyChangeListeners();
	}
	
	protected void fireChangeEvent(DirectAttribute attribute, Object oldValue, Object newValue)
	{
		if (this.ifcClassSupport != null)
			this.ifcClassSupport.fireChangeEvent(attribute, oldValue, newValue);
	}
	
	protected void classCloneAttributes(Class<?> type, IfcBase clone)
	{
		Collection<Attribute> directAttributes = Attribute.find(type, instanceOf(Attribute.class));
		if (directAttributes != null)
		{
			for (Attribute attribute : directAttributes)
			{
				if (attribute instanceof DirectAttribute)
				{
					DirectAttribute directAttribute = (DirectAttribute) attribute;
					Object value = directAttribute.get(this);
					if (value instanceof DeepCloneable)
						value = ((DeepCloneable) value).clone();
					
					// TODO: Temp Lock on firing events?
					clone.setAttributeValue(directAttribute, value);			
				}
				else if (attribute instanceof InverseAttribute)
				{
					// Set all inverses to null, becase Object.clone() make bitwise copies of the inverses.
					// Cloned objects must not share their inverses				
					attribute.set(clone, null);
				}
			}
		}
	}
	
	@Override
	public IfcBase clone()
	{
		try
		{
			IfcBase clone = (IfcBase) super.clone();
			return clone;
		}
		catch (CloneNotSupportedException ex)
		{
			ex.printStackTrace();
		}
		return null;
	}
	
	public IfcBase shallowClone()
	{
		return clone();
	}
}
>>