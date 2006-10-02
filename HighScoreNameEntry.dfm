object Frm_HSNE: TFrm_HSNE
  Left = 302
  Top = 183
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Bitte Name Eingeben'
  ClientHeight = 57
  ClientWidth = 324
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  PixelsPerInch = 120
  TextHeight = 16
  object btnok: TButton
    Left = 232
    Top = 16
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 0
  end
  object edithsne: TEdit
    Left = 16
    Top = 16
    Width = 209
    Height = 24
    MaxLength = 16
    TabOrder = 1
    OnChange = edithsneChange
  end
end
