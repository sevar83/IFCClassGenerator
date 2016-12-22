# IFCClassGenerator
Generates a complete java class hierarchy of a given IFC schema file written in the EXPRESS language.

## What it does?

1. Parses a given text file containing the definition of the IFC (Industry Foundation Classes) schema.
2. Generates a set of java source files representing the IFC object model. They can be used for various purposes - base classes, import/export, etc.
The output java source files are rendered using [StringTemplate](http://www.stringtemplate.org/) templates. Object model includes IFC primitive types, classes, enums, methods, attributes, relations, etc. Feel free to fork and modify them however they fit for your project.

## Usage

1. Run on the command line:
`java IFCClassGenerator ifc-schema.exp`
2. Copy the output java files into your project.

Note: the default package name for generated java classes is "TestIFC". That can be modified in the template files.
