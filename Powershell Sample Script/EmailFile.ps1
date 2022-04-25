#Make an SQL Query To the SQL Server
$invoke = Invoke-Sqlcmd -Query " select FirstName, LastName, Address From LandonHotel.dbo.Guests" -ServerInstance "localhost\MY_SQL_INSTANCE"
Write-Host $invoke
#Save the query response as csv file
$invoke | Export-Csv -Path "C:\Sample_Files\GuestInformation.csv"


#Store email information to pass to the Send-MailMessage parameters
$MyEmail = "sampleEmailForDaniel@gmail.com"
$SMTP = "smtp.gmail.com"
$Subject = "Important Guests List"
$Body = "Below is a csv file of the hotel guest list"
$Creds = (Get-Credential -Credential "$MyEmail")
$Attachment = "C:\Sample_Files\GuestInformation.csv"

$EmailList = Get-Content -Path "C:\Sample_Files\TheEmailList.txt"

#Sends the Email to each person in the list
foreach ($email in $EmailList) {
    $To = $email
    Write-Host $To
    #Send an email containing the csv file
    Send-MailMessage -to $To -From $MyEmail -Subject $Subject -Body $Body -SmtpServer $SMTP -Credential $Creds -UseSsl -Port  587 -DeliveryNotificationOption never -Attachments $Attachment
}




