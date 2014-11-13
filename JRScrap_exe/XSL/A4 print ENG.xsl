<?xml version="1.0"?><!-- DWXMLSource="export.xml" -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"/>

<xsl:template match="Movies">
<html> 
<head>
  
<title> Export XML </title>

<style type="text/css">
  

  
#contain {
	position:relative;
    width:190mm ; 
    height:250mm ; 
    font-size:20pt ;
	top: 5mm;
	left: 5mm; 
        }

#title {
	position:relative;
	top: 0mm;
	left: 0mm; 
	font-size:22pt ;
    width:190mm ;
	height: 15mm ;
	}
	

#picdes {
	position: relative;
	top: 0mm;
	left: 0mm;
	width:190mm ;
    height:100mm ;
    font-size:14pt ;
	   }
	   
#pic {
   position: absolute;
   top: 0mm;
   left: 0mm;
   height:100mm ; 
   width:70mm 
	 }
	 
#des {
   position:absolute;
   top: 0mm;
   right: 0mm;
   height:100mm ; 
   width:120mm ;
   } 	

   
#rowleft {
	align: left;
	width: 190mm;
	font-size: 14pt;
	font-weight: bold;
	}

#rowright {
	align: right;
	width: 190mm;
	font-size: 14pt;
	}

#spacer {
	
	position: relative;
	top:0mm;
	left:0mm; 
	height: 10mm ;
	width:190mm ;
	}
	
#spacer2 {
	
	position: relative;
	top:0mm;
	left:0mm; 
	width:190mm ;
	}
		


</style>
    
</head>
<body >
<xsl:for-each select="Movie">	


<div id = "contain">
   
<div id = "title"><xsl:value-of select="Name"/></div>
  
<div id = "picdes">
<div id = "pic"> <img src="{Image_File_HTML}" width="250 mm"/> </div> 
<div id = "des">  <xsl:value-of select="Description"/> </div> 
</div>
<div id="tags">

<div id= "spacer"></div>

<div id= "spacer2">
<div id= "rowleft">Release date :</div>
<div id= "rowright"><xsl:value-of select="Date"/></div>
</div>

<div id= "spacer"></div>

<div id= "spacer2">
<div id= "rowleft">Actors :</div>
<div id= "rowright">
<xsl:for-each select="Actors">
<xsl:value-of select="text()"/> , 
</xsl:for-each>
etc ..
</div>
</div>

<div id= "spacer"></div>

<div id= "spacer2">
  <div id= "rowleft">Directors :</div>
  <div id= "rowright">
<xsl:for-each select="Director">
 - <xsl:value-of select="text()"/> 
</xsl:for-each>
</div>
  </div>
   
</div>
	
<p style="page-break-after:always;">  </p>
</div>
<p style="page-break-after:always;">  </p>
<!-- End Div Contain-->

</xsl:for-each>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
    
