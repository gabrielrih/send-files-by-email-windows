# It sends files by e-mail. Each file in a different email.
# The script MUST BE in the same folder as the files
# Richter, Gabriel <gabrielrih@gmail.com>
# 2021-06-16

# SMTP config
$User = 'from@gmail.com'
$Server = 'smtp.gmail.com'
$Port =  587 # available just in Power Shell v3 or more
$From = 'Name <from@gmail.com>'
$To = 'Name <to@gmail.com>'

# It creates the output dir
$movedDir='done'
New-Item -ItemType Directory -Force -Path $movedDir

# Ask for password email
$credential = Get-Credential -credential $User

# Find XML files into the current directory
$List = (Get-ChildItem *.xml)

if ( $List -ne $null ) {

	# Start sending email
	Write-Output '(+)Sending files by email...' 
	Foreach ($File In $List)
	{
		Write-Output "Sending: $File"

		# Email content
		$Subject = 'XML filename: ' + $File
		$Body = 'Check the attachments.'
		$Attachment = $File

		# Send mail
		Send-MailMessage -From $From -To $To -Subject $Subject -Body $Body -SmtpServer $Server -Port $Port -UseSsl -Credential $Credential -Attachments $Attachment

		if($?) {
			mv $File $movedDir
		} else { # error
			break
		} 
	}
}


