IfcClass() ::= <<
$preamble()$

package $package()$;

import java.beans.PropertyChangeListener;


public interface IfcClass extends IfcBaseInterface
{
	void addPropertyChangeListener(PropertyChangeListener listener);
	void removePropertyChangeListener(PropertyChangeListener listener);
	//void removeAllPropertyChangeListeners();
}
>>