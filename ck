#!/opt/jdk1.8.0_202/bin/java bsh.Interpreter
final String __FILENAME__ =System.getProperty("sun.java.command").replaceAll("^.+?\\s","").replaceAll("\\s.+$","");
addClassPath(dirname(__FILENAME__)); 
importCommands("/beanshell");
globals();
/** 
ck - an abbrivation for cyberkiss
One or few kisses context for some cyber information. ck invokes the browser
browser is a variable in beanshell file beanshell/globals.bsh

ck without arguments shows the resouces available - which is actual web pages.
The address of many web pages forms an api - the 'k' in ck is a LOL likeable
name for the parameters of an api call.

It is system independt for all resources besides this one:

    japi

which looks up a java 8 package name of a class in a list of jar files and
invokes a jar file related local or remote html file.

global.bsh contain an array of Strings: jarList. One of the is

  rt=https://docs.oracle.com/javase/8/docs/api/,/opt/jdk1.8.0_202/jre/lib

Calling this
 
   ck japi Buffer

Brings up a list where one of the items for selection is

  rt: java/nio/Buffer.class

showing that /opt/jdk1.8.0_202/jre/lib/rt.jar contains class java/nio/Buffer. If other jar files, in jarList
files contains one or more classes named Buffer, the are added to the list for  choice of
selection.  

Note https:// - it can also be file:/// for local api's. Equality besides home compiled documentation and
pro is a feature  of the java language.

**/

bsh.XThis splitItemAndAfterMap(String separator, int retNumber, String indexOfParm) {
	String apply(String item) {
		int posAfter = item.indexOf(indexOfParm);
		String[] caseParts = item.split(separator);

		return 
			(caseParts[0].length() > 6 ? "\t": "")
			+caseParts[retNumber]+(posAfter > 0 ? item.substring(posAfter+indexOfParm.length()) : "");
	}
	return this;
}

if (bsh.args.length < 2) {
	List  cmds = readAllLines(__FILENAME__,matchesPredicate("\\s+case \".+"),splitItemAndAfterMap("\"",1,"//"));
	print(
		 "ck webresource kiss\nwebresource being one off\n"
		+ String.join("\n",cmds.toArray(new String[cmds.size()]))
		);
	return;
}

void cyberkiss() {
	String kiss =bsh.args[1];
	List args = new ArrayList();
	for (int i=1; i< bsh.args.length; i++)
		args.add(bsh.args[i]);
	switch (bsh.args[0]) {
	case "findrute": // fravej nr postnr tilvej nr postnr # eg. nørre+alle 23 4300 københavnsvej 34 4000
		if (bsh.args.length < 7)
			p("to few arguments, 6 needed to findrute");
		else
			browseThat("https://www.google.com/maps/dir/"+bsh.args[1]+"+"+bsh.args[2]+","+bsh.args[3]+"/"+bsh.args[4]+"+"+bsh.args[5]+","+bsh.args[6]);
		break;
	case "findvej": // vej nr postnr # eg. kisserup+strand 13 4300
		if (bsh.args.length < 4)
			p("to few arguments, 3 needed to findvej");
		else
			browseThat("https://www.google.com/maps/place/"+bsh.args[1]+"+"+bsh.args[2]+","+bsh.args[3]);
		break;
	case "phone": // number
		browseThat("https://118.dk/search/go?what="+kiss);
		break;
	case "en-da": // word
		browseThat("https://en.glosbe.com/en/da/"+URLEncoder.encode(kiss,"utf-8"));
		break;
	case "da-en": // word
		browseThat("https://da.glosbe.com/da/en/"+URLEncoder.encode(kiss,"utf-8"));
		break;
	case "en.wiki": // word [word ...]
		browseThat("https://en.wikipedia.org/wiki/"+String.join("%20",args));
		break;
	case "da.wiki": // word [word ...]
		browseThat("https://da.wikipedia.org/wiki/"+String.join("%20",args));
		break;
    case "git": // word
        browseThat("https://git-scm.com/docs/git-"+kiss);
        break;
    case "thesaurus": // word
		browseThat("https://www.thesaurus.com/browse/"+URLEncoder.encode(kiss,"utf-8"));
		break;
	case "ordnet": // word
		browseThat("https://ordnet.dk/ddo/ordbog?query="+kiss);
		break;
	case "jquery": // function
		browseThat("https://api.jquery.com/"+kiss+"/");
		break;
	case "ddgo": // word [word ...]
		browseThat("https://duckduckgo.com/?q="+String.join(" ",args));
		break;
	case "japi": // class # java class name
		List classes = jimport(kiss);
		//p(classes);
		//break;
		if (classes.size() > 0) {
			String chosenClass;
			if (classes.size() > 1) {
				chosenClass = strOfInput(classes);
				if (null == chosenClass)
					break;
			} else
				chosenClass=classes.get(0);
			String[] packPath = chosenClass.split(":");
			browseThat(japiUrl(packPath[0])+packPath[1].trim().replaceAll("\\.class\\s*$",".html"));
		} else
			p("no Class "+kiss);
		break;
	case "phpf": // function   # php function name
		browseThat("https://www.php.net/manual/en/function."+kiss.replace("_","-")+".php");
		break;
	case "phpc": // class   # php class name
		browseThat("https://www.php.net/manual/en/class."+kiss.toLowerCase().replace("_","-")+".php"); 
		break;
	case "htmltag": // elementname
		browseThat("https://developer.mozilla.org/en-US/docs/Web/HTML/Element/"+kiss);
		break;
	case "cssp": // property   # css property name like 'color'
		browseThat("https://developer.mozilla.org/en-US/docs/Web/CSS/"+kiss);
		break;
	case "css": // dummy # selection follows
		String choice = strOfInput(new String[]{"selectors","box model","pseudo classes","colors","functions"});
		switch (choice) {
			case "selectors":
				browseThat("https://developer.mozilla.org/en-US/docs/Learn/CSS/Building_blocks");
				break;
			case "box model":
				browseThat("https://developer.mozilla.org/en-US/docs/Learn/CSS/Building_blocks/The_box_model");
				break;
			case "pseudo classes":
				browseThat("https://developer.mozilla.org/en-US/docs/Learn/CSS/Building_blocks/Selectors/Pseudo-classes_and_pseudo-elements#reference_section");
				break;
			case "colors":
				browseThat("https://developer.mozilla.org/en-US/docs/Web/CSS/color_value");
				break;
			case "functions":
				browseThat("https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Functions");
		}
		break;

	case "bropages": // word
		browseThat("http://bropages.org/"+kiss);
		break;
	default:
		print(bsh.args[0]+" what?");
	}
}
cyberkiss();

