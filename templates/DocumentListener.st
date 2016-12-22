DocumentListener() ::= <<
$preamble()$

package $package()$;

import java.util.Collection;
import java.util.EventListener;

public interface DocumentListener extends EventListener
{
	//public void objectChanged(IfcClass object, DirectAttribute attribute, Object oldValue, Object newValue);
	public void objectsAdded(Collection<IfcClass> objects);
	public void objectsRemoved(Collection<IfcClass> objects);
	public void documentChanged();
}
>>