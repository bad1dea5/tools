#
#
#

Add-Type -AssemblyName PresentationCore,PresentationFramework
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

#
#
#
$release = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' –Name ReleaseId).ReleaseId
$build = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' –Name CurrentBuild).CurrentBuild
$ubr = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' –Name UBR).UBR

#
#
#
$form = New-Object System.Windows.Forms.Form
$form.Size = New-Object System.Drawing.Size(350, 150)
$form.Text = "Copy Windows system files"
$form.TopMost = $true

#
# OK
#
$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Point(170,60)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = 'OK'
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK

$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)

#
# Cancel
#
$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Point(250,60)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = 'Cancel'
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel

$form.CancelButton = $CancelButton
$form.Controls.Add($CancelButton)

#
# Label
#
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,10)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Destination'

$form.Controls.Add($label)

#
# Combo
#
$drive = New-Object System.Windows.Forms.ComboBox
$drive.Location = New-Object System.Drawing.Point(10,30)
$drive.Size = New-Object System.Drawing.Size(45,23)
$drive.Text = "Y:\"

$drive.Items.Add("C:\")
$drive.Items.Add("D:\")
$drive.Items.Add("E:\")
$drive.Items.Add("F:\")
$drive.Items.Add("X:\")
$drive.Items.Add("Y:\")
$drive.Items.Add("Z:\")

$form.Controls.Add($drive)

#
# Textbox
#
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(56,30)
$textBox.Size = New-Object System.Drawing.Size(268,20)
$textBox.Text = $release + '\' + $build + '.' + $ubr

$form.Controls.Add($textBox)

#
#
#
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    #
    #
    #
    $directory = $drive.Text + $textBox.Text

    if(!(Test-Path $directory))
    {
        New-Item -ItemType Directory -Force -Path $directory

        Copy-Item 'C:\Windows\System32\ntoskrnl.exe' $directory
        Copy-Item 'C:\Windows\System32\ntdll.dll' $directory
        Copy-Item 'C:\Windows\System32\kernel32.dll' $directory
        Copy-Item 'C:\Windows\System32\user32.dll' $directory
        Copy-Item 'C:\Windows\System32\KernelBase.dll' $directory
        Copy-Item 'C:\Windows\System32\ucrtbase.dll' $directory

        #
        #
        #
        [System.Windows.MessageBox]::Show(
            "Successfully copied to " + $directory,
            "Windows",
            [System.Windows.MessageBoxButton]::OK,
            [System.Windows.MessageBoxImage]::Information
        )
    }
}

        Copy-Item 'C:\Windows\System32\user32.dll' $version
        Copy-Item 'C:\Windows\System32\KernelBase.dll' $version
        Copy-Item 'C:\Windows\System32\ucrtbase.dll' $version
    }
}
