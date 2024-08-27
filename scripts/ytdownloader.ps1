function DownloadVideo {
	clear
	yt-dlp "$videoLink" -P $fileDestination -S res,ext:mp4:m4a --recode mp4
	clear
}

function DownloadAudio {
	clear
	yt-dlp "$videoLink" -f ba --extract-audio --audio-format $audioType -P $fileDestination
}

function VideoLink {
	clear
	Write-Host "-< Write Video Link >-"
	Write-Host "> " -NoNewLine
	$videoLink = Read-Host
	if ($startChoice -eq 1) {
		DownloadVideo
	}	else {
		DownloadAudio
	}	
}

function LocationGrab {
	clear
	Write-Host "-< Choose Destination Folder >-"
	Add-type -AssemblyName System.Windows.Forms
	$fileBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
	$result = $fileBrowser.ShowDialog()
	if ($result -eq "OK") {
		$fileDestination = $fileBrowser.SelectedPath
	} else {
		exit
	}
	VideoLink
}

function AudioMenu {
	clear
	Write-Host "-< Audio Format >-"
	Write-Host "1. MP3"
	Write-Host "2. WAV"
	Write-Host "3. < Back"
	Write-Host "> " -NoNewLine
	$audioChoice = Read-Host
	if ($audioChoice -eq 1) {
		$audioType = "mp3"
	} elseif ($audioChoice -eq 2) {
		$audioType = "wav"
	} elseif ($audioChoice -eq 3) {
		DownloadMenu
	}	else {
		AudioMenu
	}
	LocationGrab
}

function DownloadMenu {
	clear
	Write-Host "-< Download Video >-
1. Video
2. Audio
> " -NoNewLine
	$startChoice = Read-Host
	if ($startChoice -eq 1) {
		LocationGrab
	} elseif ($startChoice -eq 2) {
		AudioMenu
	}	else {
		clear
	}
}

clear
DownloadMenu