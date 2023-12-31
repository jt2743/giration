VERSION 5.00
Begin VB.Form frmCadrage 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Cadrage"
   ClientHeight    =   3255
   ClientLeft      =   2190
   ClientTop       =   1155
   ClientWidth     =   7395
   Icon            =   "CADRAGE.frx":0000
   KeyPreview      =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3255
   ScaleWidth      =   7395
   ShowInTaskbar   =   0   'False
   Begin VB.PictureBox Picture1 
      Align           =   2  'Align Bottom
      BorderStyle     =   0  'None
      Height          =   615
      Left            =   0
      ScaleHeight     =   615
      ScaleWidth      =   7395
      TabIndex        =   17
      Top             =   2640
      Width           =   7395
      Begin VB.CommandButton cmdD�signer 
         Caption         =   "PAN..."
         Height          =   320
         Index           =   1
         Left            =   1560
         TabIndex        =   5
         Top             =   120
         Width           =   1332
      End
      Begin VB.CommandButton cmdD�signer 
         Caption         =   "Zoom..."
         Height          =   320
         Index           =   0
         Left            =   120
         TabIndex        =   4
         Top             =   120
         Width           =   1332
      End
      Begin VB.CommandButton cmdZAvant 
         Caption         =   "Vue pr�c�dente"
         Height          =   320
         Left            =   4440
         TabIndex        =   7
         Top             =   120
         Width           =   1332
      End
      Begin VB.CommandButton cmdEtendu 
         BackColor       =   &H000000FF&
         Caption         =   "Tout voir"
         Height          =   320
         Left            =   5880
         TabIndex        =   8
         Top             =   120
         Width           =   1332
      End
      Begin VB.CommandButton cmdZArriere 
         Caption         =   "Zoom arri�re"
         Height          =   320
         Left            =   3000
         TabIndex        =   6
         Top             =   120
         Width           =   1332
      End
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      Default         =   -1  'True
      Height          =   320
      Left            =   5880
      TabIndex        =   9
      Top             =   240
      Width           =   1332
   End
   Begin VB.CommandButton cmdCancel 
      Cancel          =   -1  'True
      Caption         =   "Annuler"
      Height          =   320
      Left            =   5880
      TabIndex        =   10
      Top             =   720
      Width           =   1332
   End
   Begin VB.CommandButton cmdHelp 
      Caption         =   "Aide"
      Height          =   320
      Left            =   5880
      TabIndex        =   11
      Top             =   1200
      Width           =   1332
   End
   Begin VB.Frame fraLimites 
      Caption         =   " Limites"
      Height          =   2172
      Left            =   120
      TabIndex        =   12
      Top             =   120
      Width           =   5535
      Begin VB.TextBox txtX 
         Alignment       =   1  'Right Justify
         Height          =   285
         Index           =   1
         Left            =   360
         TabIndex        =   2
         Top             =   1200
         Width           =   1215
      End
      Begin VB.TextBox txtY 
         Alignment       =   1  'Right Justify
         Height          =   285
         Index           =   1
         Left            =   360
         TabIndex        =   3
         Top             =   1560
         Width           =   1215
      End
      Begin VB.TextBox txtX 
         Alignment       =   1  'Right Justify
         Height          =   285
         Index           =   0
         Left            =   360
         TabIndex        =   0
         Top             =   360
         Width           =   1215
      End
      Begin VB.TextBox txtY 
         Alignment       =   1  'Right Justify
         Height          =   285
         Index           =   0
         Left            =   360
         TabIndex        =   1
         Top             =   720
         Width           =   1215
      End
      Begin VB.Label lblX 
         Caption         =   "X"
         ForeColor       =   &H000000FF&
         Height          =   288
         Index           =   1
         Left            =   120
         TabIndex        =   16
         Top             =   1200
         Width           =   252
      End
      Begin VB.Label lblY 
         Caption         =   "Y"
         ForeColor       =   &H000000FF&
         Height          =   288
         Index           =   1
         Left            =   120
         TabIndex        =   15
         Top             =   1560
         Width           =   252
      End
      Begin VB.Shape Shape3 
         BackColor       =   &H000000FF&
         BackStyle       =   1  'Opaque
         BorderColor     =   &H000000FF&
         FillColor       =   &H00FF0000&
         Height          =   135
         Left            =   4800
         Shape           =   1  'Square
         Top             =   360
         Width           =   135
      End
      Begin VB.Shape Shape2 
         BackColor       =   &H00FF0000&
         BackStyle       =   1  'Opaque
         BorderColor     =   &H00FF0000&
         FillColor       =   &H00FF0000&
         Height          =   135
         Left            =   2400
         Shape           =   1  'Square
         Top             =   1680
         Width           =   135
      End
      Begin VB.Label lblX 
         Caption         =   "X"
         ForeColor       =   &H00FF0000&
         Height          =   285
         Index           =   0
         Left            =   120
         TabIndex        =   14
         Top             =   360
         Width           =   255
      End
      Begin VB.Label lblY 
         Caption         =   "Y"
         ForeColor       =   &H00FF0000&
         Height          =   285
         Index           =   0
         Left            =   120
         TabIndex        =   13
         Top             =   720
         Width           =   255
      End
      Begin VB.Shape Shape1 
         BackColor       =   &H00FFFFFF&
         BackStyle       =   1  'Opaque
         BorderColor     =   &H00CBDF00&
         FillColor       =   &H00CBDF00&
         FillStyle       =   0  'Solid
         Height          =   1455
         Left            =   2400
         Top             =   360
         Width           =   2535
      End
   End
End
Attribute VB_Name = "frmCadrage"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'**************************************************************************************
'     GIRATION v3 - CERTU/CETE de l'Ouest
'         Septembre 97

'   R�alisation : Andr� VIGNAUD

'   Module de feuille : frmCadrage   -   CADRAGE.FRM
'   Feuille permettant de cadrer la vue (ZOOM,PAN...)
'   Cette feuille ne s'affiche pas si elle est charg�e par un appel
'   via un bouton de frmTraject (dans ce cas la variable 'TypeZoom' est aliment�e)

'**************************************************************************************
Option Explicit

Private Modif As Boolean
Private deltaX As Single, deltaY As Single
Private basGauche As New PT, hautDroit As New PT
Private sauvX(1) As String, sauvY(1) As String
'Public ContexteHorsBouton As Boolean

'***************************************************************************************
' L'op�rateur d�finit son Zoom par cliquage
' Cette action est appel�e �galement par programme (feuille non visible) via un bouton
'***************************************************************************************
Private Sub cmdD�signer_Click(Index As Integer)
Dim i As Integer

  Me.Hide
    
  If Index = 0 Then
    gtOutilZoom = TOOL_ZOOM
  Else
    gtOutilZoom = TOOL_PAN
  End If
  
  Pr�parerZoom Index, ContexteCadrage:=True
  
'  If Index = 1 Then ' PAN ou outil de mesure
'    If FichierJournal Then Write #numFichLog, "PAN"
'    fCourante.flagPAN = True
'    If ContexteHorsBouton Then gtOutilZoom = TOOL_PAN
'  Else  ' Zoom
'    If FichierJournal Then Write #numFichLog, "ZOOM fen�tre"
'    fCourante.flagZoom = True
'    If ContexteHorsBouton Then gtOutilZoom = TOOL_ZOOM  ' En fait tjs vrai
'    bgTexte ID_ClicContextuel
'  End If
  
'  With ObjetDessin
'    .SetFocus
'    .MousePointer = vbCustom
'    If gtOutilZoom = TOOL_PAN Then
'      .MouseIcon = MDIGiration.ilsGiration.ListImages("curPAN").Picture
'       bgTexte ID_Premier & " " & ID_Point & " : "
'      MDIGiration.staMesure.Panels("Distance").Text = ""
'    ElseIf gtOutilZoom = TOOL_ZOOM Then
'      .MouseIcon = MDIGiration.ilsGiration.ListImages("curZoom").Picture
'      MDIGiration.staMesure.Panels("Distance").Text = ""
'    ElseIf gtOutil = TOOL_DIST Then
'      .MouseIcon = MDIGiration.ilsGiration.ListImages("curDistance2").Picture
'    ElseIf gtOutil = TOOL_ANGLEDYN Then
'      .MouseIcon = MDIGiration.ilsGiration.ListImages("curAngle2").Picture
'    End If
'  End With
'
'  If gtOutilZoom = 0 Then Exit Sub    ' Outil de mesure et non pas Zoom
'
'  If fCourante.Grille.Visible Then
'    fCourante.Grille.Enabled = False
'    fCourante.PICbOUTONS.Enabled = False
'  Else
'    fCourante.fraOrigine.Enabled = False
'  End If
  
End Sub

'***************************************************************************************
' Zoom Etendu : Tout voir
'***************************************************************************************
Private Sub cmdEtendu_Click()

  Me.Hide
   
   'v3.3 : Externalisation des fonctions de zoom
  ExecuteZoomEtendu
  
'  verifRetaillage
'  If FichierJournal Then Write #numFichLog, "Tout Voir"
'  ToutVoir
    
  Unload Me
'
'    Rafraichir
'    DefautCurseur
    
End Sub

'***************************************************************************************
' Affichage de la visu selon les coordonn�es saisies (ou calcul�es si Zoom arri�re)
'***************************************************************************************
Private Sub cmdOK_Click()

' L'utilisateur a fait RETOUR-CHARIOT

'  If ContexteHorsBouton Then
'    If Not (ActiveControl.name = "cmdOK" Or ActiveControl.name = "cmdZArriere") Then
'      SendKeys "{TAB}"
'      Exit Sub
'    End If
'    If Not VerifValid Then Exit Sub
'    ContexteHorsBouton = False
'  End If

  If Not (ActiveControl.name = "cmdOK" Or ActiveControl.name = "cmdZArriere") Then
    SendKeys "{TAB}"
    Exit Sub
  End If
  If Not VerifValid Then Exit Sub

  If Modif Then
    Me.Hide
    'Modif v3.3(02/05/07) : ExecuteZoom est externalis� de frmCadrage et comprend ausi le zoom arri�re
    GirStand.ExecuteZoom CSng(txtX(0).Text), CSng(txtY(0).Text), CSng(txtX(1).Text), CSng(txtY(1).Text)
'    basGauche.X = CDbl(txtX(0))
'    basGauche.Y = CDbl(txtY(0))
'    hautDroit.X = CDbl(txtX(1))
'    hautDroit.Y = CDbl(txtY(1))
'
'    verifRetaillage
'    CalcEchelle bg:=basGauche, hd:=hautDroit
'    Rafraichir
    
    Modif = False
  
  Else
    DefautCurseur
  End If

  Unload Me
  
End Sub

'***************************************************************************************
' Zoom arri�re : fen�tre de visualisation multipli�e par 2
'***************************************************************************************
Private Sub cmdZArriere_Click()
' ZOOM Arriere

  If FichierJournal Then Write #numFichLog, "Zoom Arri�re"

''    ' Calcul des coordonn�es r�elles du Zoom courant
'  deltaX = deltaX / 2
'  deltaY = deltaY / 2
'  txtX(0) = CDbl(txtX(0)) - deltaX
'  txtY(0) = CDbl(txtY(0)) - deltaY
'  txtX(1) = CDbl(txtX(1)) + deltaX
'  txtY(1) = CDbl(txtY(1)) + deltaY
'  cmdOK = True

'v3.3 : remplace les lignes pr�c�dentes
  gtOutilZoom = TOOL_ZARRIERE
  GirStand.ExecuteZArri�re
  Unload Me
End Sub

'***************************************************************************************
' Zoom avant : vue pr�c�dente
'***************************************************************************************
Private Sub cmdZAvant_Click()
' ZOOM Avant
'Dim echel As New PT
'
'  If FichierJournal Then Write #numFichLog, "Vue pr�c�dente"
'
'  verifRetaillage
'  With fCourante
'    .Milieux.Remove .Milieux.Count
'    .Echelles.Remove .Echelles.Count
''    .Form_Activate : remplac� par les 3 lignes suivantes (AV - 08.02.2000)
'    ' Alimentation des variables (d�clar�es dans GraphStand)  utiles aux fonctions de mise � l'�chelle
'    Set gtMil = .Milieux(.Milieux.Count)
'    Set echel = .Echelles(.Echelles.Count)            ' echel est une variable locale, pour d�terminer gtFacteurZoom
'    gtFacteurZoom = Min(echel.X, echel.Y)
'    ParamEcranZoom
'  End With
'
'  Me.Hide
'  Rafraichir
'  Unload Me
'
'  DefautCurseur
  
  Me.Hide
  GirStand.ExecuteZAvant
  Unload Me
  
  End Sub

'***************************************************************************************
' D�chargement de la feuille : r�activation des controles inhib�s
'***************************************************************************************
Private Sub Form_Unload(Cancel As Integer)
  
On Error GoTo GestErr


  gtOutilZoom = TOOL_SANSZOOM
'
'  With fCourante
'    .cmdZAvant.Enabled = (.Milieux.Count > 1)
'    MDIGiration.tbrGiration.Buttons("btnZAvant").Enabled = (.Milieux.Count > 1)
'    MDIGiration.mnuZoom(TOOL_ZAVANT) = (.Milieux.Count > 1)
'
'    If Not EstCharg�e(frmPas) Then
'' Ajout AV 08.02.2000 : Le Cadrage peut �tre appel� depuis le pas � pas
'      .picBoutons.Enabled = True
'    End If
'  End With
'
'  If fCourante.Grille.Visible Then fCourante.Grille.Enabled = True Else fCourante.fraOrigine.Enabled = True

  TerminerRecadrage
Exit Sub

GestErr:
  ErrGeneral
  
End Sub

Private Sub cmdHelp_Click()
  
  SendKeys "{F1}", True

End Sub

'**********************************************
' V�rification que xmin<xmax et ymin<ymax
'**********************************************
Private Function VerifValid() As Boolean
  If txtX(0) >= txtX(1) Then
    MsgBox IDm_Invalid
    txtX(0).SetFocus
  ElseIf txtY(0) >= txtY(1) Then
    MsgBox IDm_Invalid
    txtY(0).SetFocus
  Else
    VerifValid = True
  End If
End Function

Private Sub cmdCancel_Click()

    Unload Me

End Sub


' Gestion du point d�cimal comme virgule
' Si l'utilisateur est ainsi configur� (indicateur : flagVirgule), on d�tecte la frappe du point d�cimal
' mais seule la fonction KeyPress semble en mesure de r�afficher la virgule
Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
  
  If KeyCode = vbKeyDecimal And Shift = 0 Then alertVirgule = True
'    If flagVirgule Then alertVirgule = True
'    If flagVirgule Then KeyCode = 188
'  End If

End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
' L'utilisateur vient de frapper un point d�cimal en configuration virgule pour celui-ci sous Windows
' on �crit une virgule � la place
  If alertVirgule Then KeyAscii = gtPtDecimal: alertVirgule = False
End Sub

'***************************************************************************************
'***************************************************************************************
Private Sub Form_Load()

'    D�graisserFonte Me

  ' Aide contextuelle
    Me.HelpContextID = CADRAGE
    
    If FichierJournal Then Write #numFichLog, "Ouverture de Cadrage"
  ' sinon, l'appel est fait directement par un bouton dans frmTraject (on n'affiche pas la feuille)
  
  'Affichage centr� de la fen�tre
    Me.ScaleMode = vbTwips
    Me.Left = (Screen.Width - Me.Width) / 2
    Me.Top = (Screen.Height - Me.Height) / 2
    
    ' Calcul des coordonn�es r�elles du Zoom courant
    basGauche.X = fCourante.pmin.X
    basGauche.Y = fCourante.pmin.Y
    hautDroit.X = fCourante.pmax.X
    hautDroit.Y = fCourante.pmax.Y
    txtX(0) = Arrond(basGauche.X, 2)
    txtY(0) = Arrond(basGauche.Y, 2)
    txtX(1) = Arrond(hautDroit.X, 2)
    txtY(1) = Arrond(hautDroit.Y, 2)
    deltaX = Arrond(hautDroit.X - basGauche.X, 2)
    deltaY = Arrond(hautDroit.Y - basGauche.Y, 2)
    
    cmdZAvant.Enabled = (fCourante.Milieux.Count > 1)
            
End Sub

''***************************************************************************************
'' Ex�cution du Zoom suite � saisie de l'op�rateur (suite � cdmD�signer)
''***************************************************************************************
'Public Sub ExecuteZoom(X As Single, Y As Single, x0 As Single, y0 As Single)
'
'  ContexteHorsBouton = False
'  ObjetDessin.MousePointer = vbDefault '0
'
'  If gtOutilZoom = TOOL_ZOOM Then
'    basGauche.X = Arrond(trEchelX(X, True), 2)
'    basGauche.Y = Arrond(trEchelY(Y, True), 2)
'    hautDroit.X = Arrond(trEchelX(x0, True), 2)
'    hautDroit.Y = Arrond(trEchelY(y0, True), 2)
'  Else  ' PAN ou Outil de mesure
'    deltaX = Arrond(trEchelX(x0, True) - trEchelX(X, True), 2)
'    deltaY = Arrond(trEchelY(y0, True) - trEchelY(Y, True), 2)
'
'    ' Outils de mesure : Affichage du r�sultat et relance de la commande
'    If gtDistance Or gtAngleDyn Then
'      If gtDistance Then
'        MDIGiration.staMesure.Panels("Distance").Text = "Distance : " & Format(Sqr(Carre(deltaX) + Carre(deltaY)), "#0.0#")
'      End If
'      If fCourante.fraOrigine.Visible Then fCourante.fraOrigine.Enabled = True
'      gtDistance = False: gtAngleDyn = False
'      bgTexte ""
'      cmdD�signer(1) = True
'      Exit Sub
'
'    Else  'Commande PAN normale
'      basGauche.X = basGauche.X - deltaX
'      basGauche.Y = basGauche.Y - deltaY
'      hautDroit.X = hautDroit.X - deltaX
'      hautDroit.Y = hautDroit.Y - deltaY
'    End If
'  End If
'
'' d�tection d'un plantage possible, si le Zoom am�ne � une division par z�ro
'    If hautDroit.X = basGauche.X Or hautDroit.Y = basGauche.Y Then
'      MsgBox IDm_SeuilZoom, vbExclamation
'      Unload Me
'      Rafraichir
'      Exit Sub
'    End If
'
'  verifRetaillage
'  CalcEchelle bg:=basGauche, hd:=hautDroit
'  Unload Me
'
'  Rafraichir
'
'  DefautCurseur
'
'End Sub
'
'
Private Sub txtX_Change(Index As Integer)
  Modif = True
End Sub

Private Sub txtX_Validate(Index As Integer, Cancel As Boolean)
  If Not IsNumeric(txtX(Index)) Then
    MsgBox IDm_Numerique
    txtX(Index) = sauvX(Index)
    txtX(Index).SetFocus
    Cancel = True
  End If
  
End Sub

Private Sub txtY_Change(Index As Integer)
  Modif = True
End Sub


Private Sub txtX_GotFocus(Index As Integer)
  
  sauvX(Index) = txtX(Index)
  txtX(Index).SelStart = 0
  txtX(Index).SelLength = Len(txtX(Index))
  
End Sub

Private Sub txtY_GotFocus(Index As Integer)
  
  sauvY(Index) = txtY(Index)
  txtY(Index).SelStart = 0
  txtY(Index).SelLength = Len(txtY(Index))
  
End Sub
Private Sub txtY_Validate(Index As Integer, Cancel As Boolean)
  If Not IsNumeric(txtY(Index)) Then
    MsgBox IDm_Numerique
    txtY(Index) = sauvY(Index)
    txtY(Index).SetFocus
    Cancel = True
  End If
End Sub


