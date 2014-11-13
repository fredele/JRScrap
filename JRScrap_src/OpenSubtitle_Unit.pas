unit OpenSubtitle_Unit;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, IdHTTP,  MSXML ,Vcl.Grids;

function LogIn(aUsername, aPassword, aLanguage, aUserAgent: string): string;
function LogOut(aToken: string): string;
function SearchSubtitles(aToken, aSublanguageID, aMovieHash: string;
  aMovieByteSize: Cardinal): string; overload;
function SearchSubtitles(aToken, aSublanguageID: string; aImdbID: Cardinal) : string; overload;
procedure LogIn_Proc;

implementation

var
  Token: string;

function XML_RPC(aRPCRequest: string): string;
const
  cURL = 'http://api.opensubtitles.org/xml-rpc';
var
  lHTTP: TIdHTTP;
  Source, ResponseContent: TStringStream;
begin
  lHTTP := TIdHTTP.Create(nil);
  lHTTP.Request.ContentType := 'text/xml';
  lHTTP.Request.Accept := '*/*';
  lHTTP.Request.Connection := 'Keep-Alive';
  lHTTP.Request.Method := 'POST';
  lHTTP.Request.UserAgent := 'OS Test User Agent';
  Source := TStringStream.Create(aRPCRequest);
  ResponseContent := TStringStream.Create;
  try
    try
      lHTTP.Post(cURL, Source, ResponseContent);
      Result := ResponseContent.DataString;
    except
      Result := '';
    end;
  finally
    lHTTP.Free;
    Source.Free;
    ResponseContent.Free;
  end;
end;

function LogIn(aUsername, aPassword, aLanguage, aUserAgent: string): string;
const
  LOG_IN = '<?xml version="1.0"?>' + '<methodCall>' +
    '  <methodName>LogIn</methodName>' + '  <params>' + '    <param>' +
    '      <value><string>%0:s</string></value>' + '    </param>' +
    '    <param>' + '      <value><string>%1:s</string></value>' +
    '    </param>' + '    <param>' +
    '      <value><string>%2:s</string></value>' + '    </param>' +
    '    <param>' + '      <value><string>%3:s</string></value>' +
    '    </param>' + '  </params>' + '</methodCall>';
var
  str: string;
begin
  str := Format(LOG_IN, [aUsername, aPassword, aLanguage, aUserAgent]);
  Result := XML_RPC(str);

end;

procedure LogIn_Proc;
var
  i, j: Integer;
  FXMLReader: IXMLDOMDocument;
  root, node, membernode, datanode, movienode: IXMLDOMNode;
begin
  try
  FXMLReader := CoDOMDocument.Create;

  //Login for test purposes :    LogIn('', '', 'en', 'OS Test User Agent')   //
  FXMLReader.loadXML(LogIn('fredele', '', 'en', 'JROpenSub'));
  root := FXMLReader.DocumentElement;

  if root.childNodes[0].nodeName = 'params' then
  begin
    node := root.childNodes[i];
    if node.childNodes[0].nodeName = 'param' then
    begin
      node := node.childNodes[0];
      if node.childNodes[0].nodeName = 'value' then
      begin
        node := node.childNodes[0];
        if node.childNodes[0].nodeName = 'struct' then
        begin
          node := node.childNodes[0];

          for j := 0 to node.childNodes.length - 1 do
          begin
            if node.childNodes[j].nodeName = 'member' then
            begin
              membernode := node.childNodes[j];

              if ((membernode.childNodes[0].text = 'token') and
                (membernode.childNodes[0].nodeName = 'name')) then
                if (membernode.childNodes[1].nodeName = 'value') then
                begin
                  Token := membernode.childNodes[1].text;

                end;
            end;
          end;

        end;

      end;
    end;
  end;
  except

  end;
end;

function LogOut(aToken: string): string;
const
  LOG_OUT = '<?xml version="1.0"?>' + '<methodCall>' +
    '  <methodName>LogOut</methodName>' + '  <params>' + '    <param>' +
    '      <value><string>%0:s</string></value>' + '    </param>' +
    '  </params>' + '</methodCall>';
begin
  Result := XML_RPC(Format(LOG_OUT, [aToken]));
end;

function SearchSubtitles(aToken, aSublanguageID, aMovieHash: string;
  aMovieByteSize: Cardinal): string;
const
  SEARCH_SUBTITLES = '<?xml version="1.0"?>' + '<methodCall>' +
    '  <methodName>SearchSubtitles</methodName>' + '  <params>' + '    <param>'
    + '      <value><string>%0:s</string></value>' + '    </param>' +
    '  <param>' + '   <value>' + '    <array>' + '     <data>' + '      <value>'
    + '       <struct>' + '        <member>' +
    '         <name>sublanguageid</name>' +
    '         <value><string>%1:s</string>' + '         </value>' +
    '        </member>' + '        <member>' + '         <name>moviehash</name>'
    + '         <value><string>%2:s</string></value>' + '        </member>' +
    '        <member>' + '         <name>moviebytesize</name>' +
    '         <value><double>%3:d</double></value>' + '        </member>' +
    '       </struct>' + '      </value>' + '     </data>' + '    </array>' +
    '   </value>' + '  </param>' + ' </params>' + '</methodCall>';

begin
  Result := XML_RPC(Format(SEARCH_SUBTITLES, [aToken, aSublanguageID,
    aMovieHash, aMovieByteSize]));
end;

function SearchSubtitles(aToken, aSublanguageID: string;
  aImdbID: Cardinal): string;
const
  SEARCH_SUBTITLES = '<?xml version="1.0"?>' + '<methodCall>' +
    '  <methodName>SearchSubtitles</methodName>' + '  <params>' + '    <param>'
    + '      <value><string>%0:s</string></value>' + '    </param>' +
    '  <param>' + '   <value>' + '    <array>' + '     <data>' + '      <value>'
    + '       <struct>' + '        <member>' +
    '         <name>sublanguageid</name>' +
    '         <value><string>%1:s</string>' + '         </value>' +
    '        </member>' + '        <member>' + '         <name>imdbid</name>' +
    '         <value><string>%2:d</string></value>' + '        </member>' +
    '       </struct>' + '      </value>' + '     </data>' + '    </array>' +
    '   </value>' + '  </param>' + ' </params>' + '</methodCall>';

begin
  Result := XML_RPC(Format(SEARCH_SUBTITLES, [aToken, aSublanguageID,
    aImdbID]));
end;



end.
