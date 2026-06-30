codeunit 50005 "HSBC ACK 2 Processor"
{
    procedure ImportACK2()
    var
        FileName: Text;
        InS: InStream;
    begin
        if not UploadIntoStream('Select HSBC ACK 2 File', '', 'XML Files (*.xml)|*.xml', FileName, InS) then
            exit;

        XmlPort.Import(XmlPort::"HSBC ACK2 Import", InS);

        Message('ACK File %1 imported successfully.', FileName);
    end;
}
