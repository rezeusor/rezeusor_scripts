// 'Create Fontsheets.fla' AND 'Create Fontsheets.as' AND 'Create Fontsheets.swf'
/* 
A panel extension for Adobe Fireworks8+ that creates a set of pages
containing all of your available fonts, which are printed using
a piece of text and a font size that you indicate.

NOTE: This was made AS2 compatible so more people can enjoy it. :0) 

From rezeusor with love!
*/

// Needed Packages
import flash.text.Font;
import flash.text.FontType;
import flash.text.FontStyle;

// Main function. Gathers all system Fonts, parses form inputs, and creates Fontsheets
function makeFontSheets(){
		MMExecute('fw.setFloaterVisibility("Create Fontsheets",false);');
        var dFonts:Array = getAllFonts();
		var fText = ftext.text;
		var fSize = fsize.value;
		var showNs = incFNames.value;
		if( (fText.indexOf("'") > -1) or (fText.indexOf('"') > -1) or (fText.indexOf("<") > -1) or (fText.indexOf(">") > -1) or (fText.indexOf(".") > -1) or (fText.indexOf("/") > -1) or (fText.indexOf("\\") > -1)){
			MMExecute('fw.setFloaterVisibility("Create Fontsheets",true);');
			MMExecute('alert("There was a bad character entered, please try again");');
			return false;
		}
		fText = escape(fText);
		var x = 0;
		var y = 0;
		var cont = true;
		MMExecute('fw.createDocument();');
		for(var f in dFonts){
			if(cont){
				if(x >= 1600){
					x = 0;
					y = y + 51 ;
				}
			}
			// Font Name Label
			if(showNs){
				MMExecute('fw.getDocumentDOM().addNewText({left:'+x+', top:'+y+', right:'+(x+200)+', bottom:'+(y+20)+'}, false);');
				MMExecute('runs = fw.selection[0].textRuns;');
				MMExecute('runs.textRuns = [{changedAttrs:{face:"Arial",size:"10pt"}, characters: "'+dFonts[f]+'"}];');
				MMExecute('fw.selection[0].textRuns = runs;');
			// Font Example
				MMExecute('fw.getDocumentDOM().addNewText({left:'+x+', top:'+(y+10)+', right:'+(x+210)+', bottom:'+(y+50)+'}, false);');
			}else{
				MMExecute('fw.getDocumentDOM().addNewText({left:'+x+', top:'+y+', right:'+(x+210)+', bottom:'+(y+50)+'}, false);');
			}
				MMExecute('runs = fw.selection[0].textRuns;');
				MMExecute('runs.textRuns = [{changedAttrs:{face:"'+dFonts[f]+'",size:'+fSize+'+"pt"}, characters: "'+fText+'"}];');
				MMExecute('fw.selection[0].textRuns = runs;');
			x = x + 212;
			if((f gt 0) and (f % 363 == 0)){
		 		MMExecute('fw.getDocumentDOM().setDocumentCanvasSizeToDocumentExtents(true);');
				MMExecute('fw.createDocument();');
		 		x = 0;
				y = 0;
			}
		}
		// Shameless Plug...
		MMExecute('fw.getDocumentDOM().setDocumentCanvasSizeToDocumentExtents(true);');
		MMExecute('fw.createDocument();');
		MMExecute('fw.getDocumentDOM().addNewText({left:0, top:0, right:1100, bottom:90}, false);');
		MMExecute('runs = fw.selection[0].textRuns;');
		MMExecute('runs.textRuns = [{changedAttrs:{face:"Arial",size:"96pt"}, characters: "From rezeusor with love!"}];');
		MMExecute('fw.selection[0].textRuns = runs;');
		MMExecute('fw.getDocumentDOM().setDocumentCanvasSizeToDocumentExtents(true);');
}
// Enumerate out all Fonts available on the device, and return them in an Array
function getAllFonts():Array {
              //Uncomment this line for AS3+
			//AS3 var allFonts:Array = Font.enumerateFonts(true);
			  //Comment out this line for AS3+
			var allFonts:Array = TextField.getFontList();
            var fontNames:Array = [];
            for(var font in allFonts){
                 //Uncomment these lines for AS3+
			   //AS3 if (font.fontType == FontType.EMBEDDED || font.fontStyle != FontStyle.REGULAR)
               //AS3     continue;
               //AS3 deviceFontNames.push(font.fontName);
			     //Comment out this line for AS3+
			   fontNames.push(allFonts[font]);	
            }            
            fontNames.sort(1);
			trace(fontNames);
            return fontNames;
}
// The button the user clicks to trigger the Fontsheets creation
CreateButton.onPress = function(){
	_root.makeFontSheets();
}