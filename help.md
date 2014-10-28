# Help
 
How to Install  :
-------------

Download the setup :

[Setup](https://github.com/fredele/JRScrap/releases/download/first_release/Setup_for_JRScrap.exe)

the setup will download automatically 2 librairies :

* Microsoft Visual C++ 2008 Redistributable Package (x86) 
http://www.microsoft.com/downloads/details.aspx?familyid=9B2DA534-3E03-4391-8A4D-074B9F2BC1BF

* OpenSSL :
http://slproweb.com/download/Win32OpenSSL_Light-1_0_1j.exe

**This librairies MUST be installed !**

How to use it :
-------------
First be sure that the correct languages are set :

In the Menu :
* Select language : selects the language for the app itself
* Select query language : selects the language for the TheMovie.org retrieved info.

Normally, if you have selected your language in the setup run, it's already done ...

After that, well, it' straight forward :

Select the Video category you want to edit in the ListBox.
The Media Browser fills up with your files.


Select  a Media in the Media browser.
The info already written in JRiver's database do appear.

To search this Media :

Select 'by Title' (if not empty !),correct the Media name and 
hit 'search this Media'.The list fills with possible Media found.Select one and hit 'retrieve the Media'

or 

Select 'Imdb ID', correct the number who shows up if necessary and hit 'retrieve the Media'



Check the boxes from the fiels you want to be saved.

**Hit Write** on the bottom of the Window, now you're viewing again the content of the updated JRiver's fields.

There's a feature to automate the process.
Go to the Menu, select 'Scrap Medias from this line'

A window appears, click on the button with the 3 dots to select the fields to be imported

Hit 'Go!'

**Be carefull** and do no scrap 100's of Media at a time.
So , hit stop, control thngs, and so on ...


Option and optionnal Mode :
-------------

In the Menu, you have some options to be set. Each one is so clear that further explanation is to much. You can translate the app., select the query language, and so forth ...

How  it works :
-------------

JRScrap connects to the various Web APIs and parses the informations.
The informations are written in the JRiver Media Center database and in the JRiver XML Carside.
The connection with JRiver Media Center is made possible by a COM objet.
See more here : 
http://delphi.about.com/library/weekly/aa122804a.htm

Limitations :
-------------

This app does not update correctly in JRiver as a remote, only on a server machine with local paths to the Movies files.
It' s not a replacement for the tagging feature provided by JRiver Media Center, only for retrieving information in your language.


 




