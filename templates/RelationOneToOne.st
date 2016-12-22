RelationOneToOne() ::= <<
$preamble()$

package $package()$;


/**
 * Relation 1-to-1
 * 
 * @author Svetlozar Kostadinov
 *
 * @param <RELATING> Type of the relating object
 * @param <RELATED> Type of the related object
 */
public interface RelationOneToOne<RELATING extends IfcClass, RELATED extends IfcClass> extends Relation<RELATING>
{	
	public RELATED getRelatedObject();
}
>>