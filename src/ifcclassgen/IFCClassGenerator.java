package ifcclassgen;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Locale;
import java.util.Map;

import org.stringtemplate.v4.AttributeRenderer;
import org.stringtemplate.v4.ST;
import org.stringtemplate.v4.STErrorListener;
import org.stringtemplate.v4.STGroup;
import org.stringtemplate.v4.STGroupDir;
import org.stringtemplate.v4.misc.STMessage;

import expressomg.AggregationType;
import expressomg.ArrayType;
import expressomg.BagType;
import expressomg.BinaryType;
import expressomg.BooleanType;
import expressomg.DeclaredType;
import expressomg.EntityType;
import expressomg.EnumerationType;
import expressomg.ExplicitAttribute;
import expressomg.ExpressOMG;
import expressomg.ExpressObjectModel;
import expressomg.IntegerType;
import expressomg.ListType;
import expressomg.LogicalType;
import expressomg.NumberType;
import expressomg.RealType;
import expressomg.Schema;
import expressomg.SelectType;
import expressomg.SetType;
import expressomg.SimpleType;
import expressomg.StringType;
import expressomg.Type;

public class IFCClassGenerator
{
	private final ExpressObjectModel ifcObjectModel;
	private final STGroup templates;
	private String outputPath;
	
	protected static class ParameterMap extends LinkedHashMap<String, Object>
	{		
	}
	
	public class CustomStringRenderer implements AttributeRenderer 
	{
		public String toString(Object o, String formatString, Locale locale) 
    {
			String string = (String) o;
			if (formatString == null)
				return o.toString();
			
			if (formatString.equals("cap"))
			{
				return capitalizeFirstLetter(string);
			}
			else if (formatString.equals("decap"))
			{
				return decapitalizeFirstLetter(string);
			}
			else if (formatString.equals("capunder"))
			{
				return capitalizedWithUnderscore(string);
			}
			else
				return string.toString();
    }
	}
	
	public IFCClassGenerator(BufferedInputStream inputStream, String outputPath)
	{
		this.ifcObjectModel = new ExpressOMG(inputStream).generate();		
		this.templates = new STGroupDir("templates", '$', '$');		
		this.templates.importTemplates(new STGroupDir("templates/reflect", '$', '$'));
		//this.templates.registerRenderer(ExplicitAttribute.class, new EntityExplicitAttributeRenderer());
		this.templates.registerRenderer(String.class, new CustomStringRenderer());
		this.outputPath = outputPath;
	}
	
	public boolean generateClasses()
	{
		generateBasicClasses();
		
		for (Schema schema : this.ifcObjectModel.getSchemas().values())
		{			
			for (Type type : schema.getTypes().values())
			{
				try
				{	
					processType(type);
				}
				catch (Exception ex)
				{					
					ex.printStackTrace();
				}
			}
		}
		
		return true;
	}
	
	protected void processType(Type type)
	{
		processType(type, type);		
	}
	
	protected void processType(Type outerType, Type currentType)
	{				
		ParameterMap parameters = new ParameterMap();
		
		if (currentType instanceof DeclaredType)
		{							
			//parameters.put("declType", type);
			processType(outerType, ((DeclaredType) currentType).getUnderlyingType());
		}
		if (currentType instanceof EnumerationType)
		{
			parameters.put("declType", outerType);
			generateENUMClass(parameters);
		}
		else if (currentType instanceof SimpleType)
		{							
			parameters.put("declType", outerType);
			generateSIMPLETYPEClass((SimpleType) currentType, parameters);
		}
		else if (currentType instanceof EntityType)
		{							
			if (currentType.isSubTypeOf("IfcRelationship"))
			{
				EntityType relationship = (EntityType) currentType;
				for (ExplicitAttribute explAttribute : relationship.getExplicitAttributes())
				{
					String attrId = explAttribute.getId();
					String[] relationAttributes = RELATION_ATTRIBUTE_MAP.get(relationship.getId());
					if (relationAttributes == null || relationAttributes.length != 2)
					{
						//throw new IllegalStateException("Must register " + relationship.getId() + " to RELATION_ATTRIBUTE_MAP");
					}
					else
					{
						if (relationAttributes[0].equals(attrId))
						{
							explAttribute.setOverridenId("RelatingAttribute");
						}
						else if (relationAttributes[1].equals(attrId))
						{
							explAttribute.setOverridenId("RelatedAttribute");
						}
						System.out.println(relationship);
					}
				}
			}
			parameters.put("entity", outerType);
			generateENTITYClass(parameters);
		}
		else if (currentType instanceof SelectType)
		{
			parameters.put("type", outerType);
			generateSELECTInterface(parameters);
		}
		else if (currentType instanceof AggregationType)
		{	
			parameters.put("declType", outerType);
			generateAGGREGATIONTYPEClass(currentType, parameters);
		}
	}
	
	protected void generateBasicClasses()
	{		
		ParameterMap parameters = new ParameterMap();
			
		generateClass("DeepCloneable", parameters);
		generateClass("DocumentAdapter", parameters);
		generateClass("DocumentEvent", parameters);
		generateClass("DocumentListener", parameters);
		generateClass("Guid", parameters);
		generateClass("GuidCompressor", parameters);
		generateClass("StringConverter", parameters);
		generateClass("IfcBase", parameters);
		generateClass("IfcBaseInterface", parameters);
		generateClass("IfcClass", parameters);
		generateClass("IfcClassSupport", parameters);	
		generateClass("AggregationType", parameters);
		generateClass("Relation", parameters);
		generateClass("RelationEvent", parameters);
		generateClass("RelationListener", parameters);
		generateClass("RelationOneToOne", parameters);
		generateClass("RelationOneToMany", parameters);			
		generateClass("Type", parameters);
		generateClass("ENUM", parameters);
		generateClass("REAL", parameters);		
		generateClass("INTEGER", parameters);
		generateClass("LIST", parameters);
		generateClass("BOOLEAN", parameters);
		generateClass("LOGICAL", parameters);
		generateClass("BINARY", parameters);
		generateClass("STRING", parameters);
		generateClass("SET", parameters);
		generateClass("BAG", parameters);
		generateClass("LIST", parameters);
		generateClass("ARRAY", parameters);
		generateClass("reflect/AggregationAttribute", "AggregationAttribute", parameters);
		generateClass("reflect/Attribute", "Attribute", parameters);
		generateClass("reflect/AttributeAccessor", "AttributeAccessor", parameters);
		generateClass("reflect/AttributeInfo", "AttributeInfo", parameters);
		generateClass("reflect/DerivedAttribute", "DerivedAttribute", parameters);
		generateClass("reflect/DirectAttribute", "DirectAttribute", parameters);
		generateClass("reflect/FieldBasedAttribute", "FieldBasedAttribute", parameters);
		generateClass("reflect/InverseAttribute", "InverseAttribute", parameters);
		generateClass("reflect/MethodBasedAttribute", "MethodBasedAttribute", parameters);
		generateClass("reflect/RelatedAttribute", "RelatedAttribute", parameters);
		generateClass("reflect/RelatingAttribute", "RelatingAttribute", parameters);
		generateClass("reflect/RelationshipAttribute", "RelationshipAttribute", parameters);
		generateClass("reflect/SetAccessor", "SetAccessor", parameters);
		generateClass("reflect/SetAttribute", "SetAttribute", parameters);
		generateClass("reflect/SimpleAttribute", "SimpleAttribute", parameters);
	}
	
	protected void generateSIMPLETYPEClass(SimpleType baseType, ParameterMap parameters)
	{
		Type declType = (Type) parameters.get("declType");
		String primitiveType = primitiveType(baseType);
		String templateName = null;
		
		// LOGICAL and STRING are simple types that use primitive wrapped classed Boolean and String (not boolean and char[])
		if (primitiveType.equals("String"))
			templateName = "STRINGClass";			 
		else if (primitiveType.equals("Boolean"))
			templateName = "LOGICALClass";
		else
			templateName = "SIMPLETYPEClass";
					
		parameters.put("primitiveType", primitiveType);		
		generateClass(declType.getId(), templateName, parameters);
	}
	
	protected void generateAGGREGATIONTYPEClass(Type underlyingType, ParameterMap parameters)
	{
		Type declType = (Type) parameters.get("declType"); 
		String aggId;
		if (underlyingType instanceof SetType)
			aggId = "SET";
		else if (underlyingType instanceof BagType)
			aggId = "BAG";
		else if (underlyingType instanceof ListType)
			aggId = "LIST";
		else if (underlyingType instanceof ArrayType)
			aggId = "ARRAY";
		else
			return;		
		
		String declTypeId = declType.getId();
		parameters.put("aggId", aggId);
		generateClass(declTypeId, "AGGREGATIONTYPEClass", parameters);
	}
	
	protected void generateENUMClass(ParameterMap parameters)
	{
		String declTypeId = ((Type) parameters.get("declType")).getId();
		generateClass(declTypeId, "ENUMClass", parameters);
	}
	
	protected void generateENTITYClass(ParameterMap parameters)
	{
		String entityId = ((Type) parameters.get("entity")).getId();
		generateClass(entityId, "ENTITYClass", parameters);
	}
	
	protected void generateSELECTInterface(ParameterMap parameters)
	{
		String declTypeId = ((Type) parameters.get("type")).getId();
		generateClass(declTypeId, "SELECTInterface", parameters);
	}
	
	protected void generateClass(String templateName, ParameterMap parameters)
	{
		generateClass(templateName, templateName, parameters);
	}
	
	protected void generateClass(String outputName, String templateName, ParameterMap parameters)
	{
		ST st = this.templates.getInstanceOf(templateName);
		if (st == null)
			throw new IllegalArgumentException("Cannot get instance of template " + templateName);
		
		for (String key : parameters.keySet())
		{
			st.add(key, parameters.get(key));			
		}
		
		//st.render();
		try
		{
			final String baseOut = (this.outputPath != null) ? this.outputPath : "out";
			final String filenameOut = baseOut + "/" + outputName + ".java";
			String path = filenameOut.substring(0, filenameOut.lastIndexOf("/"));
			new File(path).mkdirs();
			File fileOut = new File(filenameOut);
						
			st.write(fileOut, new STErrorListener()
			{							
				@Override
				public void runTimeError(STMessage msg)
				{
					System.out.print(filenameOut + ": ");
					System.out.println(msg);
				}
				
				@Override
				public void internalError(STMessage msg)
				{
					System.out.print(filenameOut + ": ");
					System.out.println(msg);
				}
				
				@Override
				public void compileTimeError(STMessage msg)
				{
					System.out.print(filenameOut + ": ");
					System.out.println(msg);
				}
				
				@Override
				public void IOError(STMessage msg)
				{
					System.out.print(filenameOut + ": ");
					System.out.println(msg);
				}
			});
			//st.write(new AutoIndentWriter(new FileWriter("out/" + declType.getId() + ".java")));
		}
		catch (IOException ex)
		{			
			ex.printStackTrace();
		}
	}
	
	private String primitiveType(SimpleType simpleType)
	{
		if (simpleType instanceof RealType)
			return "float";		// Could be double for extra precision, but using float is more memory and speed effective 
		else if (simpleType instanceof IntegerType)
			return "int";
		else if (simpleType instanceof NumberType)
			return "float";
		else if (simpleType instanceof BinaryType)
			return "BitSet";
		else if (simpleType instanceof BooleanType)
			return "boolean";
		else if (simpleType instanceof LogicalType)
			return "Boolean";
		else if (simpleType instanceof StringType)
			return "String";
		else
			return "null";
	}
		
	private String capitalizeFirstLetter(String string)
	{
		return Character.toUpperCase(string.charAt(0)) + string.substring(1);
	}
	
	private String decapitalizeFirstLetter(String string)
	{
		return Character.toLowerCase(string.charAt(0)) + string.substring(1);
	}
	
	private String capitalizedWithUnderscore(String string)
	{
		StringBuffer capitalized = new StringBuffer(string.toUpperCase());
		
		int offset = 0;
		char[] chars = string.toCharArray();
		for (int i = 0; i < chars.length; i++)
		{
			if (Character.isUpperCase(chars[i]) && i > 0)
			{
				capitalized.insert(i + offset++, '_');
			}
		}
		return capitalized.toString();
	}
	
	// Map of Relationship class -> [relating attribute id, related attribute id]
	private static Map<String, String[]> RELATION_ATTRIBUTE_MAP = new HashMap<String, String[]>();
	static
	{
		RELATION_ATTRIBUTE_MAP.put("IfcRelContainedInSpatialStructure", new String[] { "RelatingStructure", "RelatedElements" });
		/*RELATION_ATTRIBUTE_MAP.put("", new String[] { "", "" });
		RELATION_ATTRIBUTE_MAP.put("", new String[] { "", "" });
		RELATION_ATTRIBUTE_MAP.put("", new String[] { "", "" });
		RELATION_ATTRIBUTE_MAP.put("", new String[] { "", "" });
		RELATION_ATTRIBUTE_MAP.put("", new String[] { "", "" });
		RELATION_ATTRIBUTE_MAP.put("", new String[] { "", "" });
		RELATION_ATTRIBUTE_MAP.put("", new String[] { "", "" });
		RELATION_ATTRIBUTE_MAP.put("", new String[] { "", "" });
		RELATION_ATTRIBUTE_MAP.put("", new String[] { "", "" });
		RELATION_ATTRIBUTE_MAP.put("", new String[] { "", "" });
		RELATION_ATTRIBUTE_MAP.put("", new String[] { "", "" });
		RELATION_ATTRIBUTE_MAP.put("", new String[] { "", "" });
		RELATION_ATTRIBUTE_MAP.put("", new String[] { "", "" });
		RELATION_ATTRIBUTE_MAP.put("", new String[] { "", "" });
		RELATION_ATTRIBUTE_MAP.put("", new String[] { "", "" });
		RELATION_ATTRIBUTE_MAP.put("", new String[] { "", "" });
		RELATION_ATTRIBUTE_MAP.put("", new String[] { "", "" });
		RELATION_ATTRIBUTE_MAP.put("", new String[] { "", "" });
		RELATION_ATTRIBUTE_MAP.put("", new String[] { "", "" });
		RELATION_ATTRIBUTE_MAP.put("", new String[] { "", "" });
		RELATION_ATTRIBUTE_MAP.put("", new String[] { "", "" });*/
	}
	
	public static void main(String[] argv)
	{
		String fileIn;
		
		switch (argv.length) 
		{
			case 1:
		    File file = new File(argv[0]);
		    if (!file.canRead()) 
		    {
					System.err.println("Unable to read file " + argv[0]);
					System.exit(1);
				}
		    fileIn = argv[0];

				try
				{
					FileInputStream in = new FileInputStream(fileIn);
					BufferedInputStream input = new BufferedInputStream(in);
					IFCClassGenerator ifcGen = new IFCClassGenerator(input, file.getParentFile().getAbsolutePath());
					ifcGen.generateClasses();
				}
				catch (FileNotFoundException e)
				{
					// TODO Auto-generated catch block
					e.printStackTrace();
				}				
				
		    break;
			default:
		    System.err.println("Usage: java IFCClassGenerator express-file-in");
		    System.exit(1);
		}
	}
}
