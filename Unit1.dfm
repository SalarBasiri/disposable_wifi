object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Disposable WiFi by Salar Basiri'
  ClientHeight = 540
  ClientWidth = 414
  Color = clBtnHighlight
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 8
    Top = 479
    Width = 38
    Height = 19
    Caption = 'Text'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 17
    Top = 295
    Width = 51
    Height = 16
    Caption = 'Encoding'
    Visible = False
  end
  object Label3: TLabel
    Left = 225
    Top = 295
    Width = 62
    Height = 16
    Caption = 'Quiet Zone'
    Visible = False
  end
  object PaintBox1: TPaintBox
    Left = 65
    Top = 122
    Width = 300
    Height = 300
    OnPaint = PaintBox1Paint
  end
  object Label4: TLabel
    Left = 8
    Top = 427
    Width = 39
    Height = 19
    Caption = 'SSID'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 169
    Top = 429
    Width = 78
    Height = 19
    Caption = 'Password'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object step_label: TLabel
    Left = 154
    Top = 55
    Width = 6
    Height = 23
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object cmbEncoding: TComboBox
    Left = 17
    Top = 319
    Width = 145
    Height = 24
    ItemIndex = 0
    TabOrder = 0
    Text = 'Auto'
    Visible = False
    OnChange = cmbEncodingChange
    Items.Strings = (
      'Auto'
      'Numeric'
      'Alphanumeric'
      'ISO-8859-1'
      'UTF-8 without BOM'
      'UTF-8 with BOM')
  end
  object edtText: TEdit
    Left = 8
    Top = 501
    Width = 394
    Height = 27
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    Text = 'WIFI:S:MySSID;T:WPA;P:MyPassW0rd;;'
    OnChange = edtTextChange
  end
  object edtQuietZone: TEdit
    Left = 196
    Top = 319
    Width = 121
    Height = 24
    TabOrder = 2
    Text = '4'
    Visible = False
    OnChange = edtQuietZoneChange
  end
  object ssid_edit: TEdit
    Left = 8
    Top = 446
    Width = 89
    Height = 27
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    Text = 'ssid'
  end
  object password_edit: TEdit
    Left = 169
    Top = 448
    Width = 177
    Height = 27
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    Text = 'password'
  end
  object generate_btn: TButton
    Left = 17
    Top = 10
    Width = 385
    Height = 39
    Caption = 'Generate SSID + Password + QR code'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = generate_btnClick
  end
  object Memo1: TMemo
    Left = 408
    Top = 24
    Width = 529
    Height = 89
    Lines.Strings = (
      
        '[Windows.System.UserProfile.LockScreen,Windows.System.UserProfil' +
        'e,ContentType=WindowsRuntime] | Out-Null'
      ''
      ''
      'Add-Type -AssemblyName System.Runtime.WindowsRuntime'
      
        '$asTaskGeneric = ([System.WindowsRuntimeSystemExtensions].GetMet' +
        'hods() | ? { $_.Name -eq '#39'AsTask'#39' -and $_.GetParameters().Count ' +
        '-eq 1 -and $_.GetParameters()[0].ParameterType.Name -eq '#39'IAsyncO' +
        'peration`1'#39' })[0]'
      'Function Await($WinRtTask, $ResultType) {'
      '    $asTask = $asTaskGeneric.MakeGenericMethod($ResultType)'
      '    $netTask = $asTask.Invoke($null, @($WinRtTask))'
      '    $netTask.Wait(-1) | Out-Null'
      '    $netTask.Result'
      '}'
      'Function AwaitAction($WinRtAction) {'
      
        '    $asTask = ([System.WindowsRuntimeSystemExtensions].GetMethod' +
        's() | ? { $_.Name -eq '#39'AsTask'#39' -and $_.GetParameters().Count -eq' +
        ' 1 -and !$_.IsGenericMethod })[0]'
      '    $netTask = $asTask.Invoke($null, @($WinRtAction))'
      '    $netTask.Wait(-1) | Out-Null'
      '}'
      ''
      ''
      
        '$connectionProfile = [Windows.Networking.Connectivity.NetworkInf' +
        'ormation,Windows.Networking.Connectivity,ContentType=WindowsRunt' +
        'ime]::GetInternetConnectionProfile()'
      
        '$tetheringManager = [Windows.Networking.NetworkOperators.Network' +
        'OperatorTetheringManager,Windows.Networking.NetworkOperators,Con' +
        'tentType=WindowsRuntime]::CreateFromConnectionProfile($connectio' +
        'nProfile)'
      ''
      ''
      
        '$configuration = new-object Windows.Networking.NetworkOperators.' +
        'NetworkOperatorTetheringAccessPointConfiguration')
    ScrollBars = ssBoth
    TabOrder = 6
    Visible = False
  end
  object Memo2: TMemo
    Left = 408
    Top = 128
    Width = 529
    Height = 89
    Lines.Strings = (
      ''
      
        '[enum]::GetValues([Windows.Networking.NetworkOperators.Tethering' +
        'WiFiBand])'
      '$configuration | Get-Member '
      ''
      ''
      ''
      '$tetheringManager.TetheringOperationalState'
      ''
      ''
      
        'AwaitAction ($tetheringManager.ConfigureAccessPointAsync($config' +
        'uration))'
      ''
      ''
      ''
      
        'Await ($tetheringManager.StartTetheringAsync()) ([Windows.Networ' +
        'king.NetworkOperators.NetworkOperatorTetheringOperationResult])')
    ScrollBars = ssBoth
    TabOrder = 7
    Visible = False
  end
  object Memo3: TMemo
    Left = 408
    Top = 240
    Width = 529
    Height = 89
    Lines.Strings = (
      'Memo3')
    ScrollBars = ssBoth
    TabOrder = 8
    Visible = False
  end
  object Creat_btn: TButton
    Left = 16
    Top = 64
    Width = 386
    Height = 41
    Caption = 'Creat WiFi Hotspot (Windows 10 only)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    OnClick = Creat_btnClick
  end
  object Button1: TButton
    Left = 352
    Top = 449
    Width = 50
    Height = 25
    Caption = 'Copy'
    TabOrder = 10
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 103
    Top = 449
    Width = 50
    Height = 25
    Caption = 'Copy'
    TabOrder = 11
    OnClick = Button2Click
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 224
    Top = 184
  end
end
