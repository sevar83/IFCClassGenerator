IfcClassSupport() ::= <<
$preamble()$

package $package()$;

import java.beans.PropertyChangeEvent;
import java.beans.PropertyChangeListener;
import java.util.HashSet;

import $package_reflect()$.DirectAttribute;


public class IfcClassSupport
{
	private IfcClass object;
	private HashSet<PropertyChangeListener> listeners = null;
	
	public IfcClassSupport(IfcClass object)
	{
		if (object == null)
			throw new NullPointerException("Null object");
		
		this.object = object;
	}
	
	public void addObjectChangeListener(PropertyChangeListener listener)
	{
		if (this.listeners == null)	
			this.listeners = new HashSet<PropertyChangeListener>(1, 1);
		this.listeners.add(listener);
	}
	
	public void removeObjectChangeListener(PropertyChangeListener listener)
	{
		if (this.listeners == null)	
			return;
		this.listeners.remove(listener);
	}

	public void removeAllPropertyChangeListeners()
	{
		this.listeners = null;
	}
	
	public void fireChangeEvent(DirectAttribute attribute, Object oldValue, Object newValue)
	{
		if (this.listeners == null) 
			return;
		for (PropertyChangeListener listener : this.listeners)
		{
			PropertyChangeEvent propertyEvent = new PropertyChangeEvent(this.object, attribute.getName(), oldValue, newValue);
			listener.propertyChange(propertyEvent);
		}
	}
}
>>