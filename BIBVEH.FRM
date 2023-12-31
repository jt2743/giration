VERSION 5.00
Begin VB.Form frmBibV�hicule 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Biblioth�que de v�hicules"
   ClientHeight    =   4860
   ClientLeft      =   2310
   ClientTop       =   4200
   ClientWidth     =   5460
   ClipControls    =   0   'False
   Icon            =   "BIBVEH.frx":0000
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4860
   ScaleWidth      =   5460
   ShowInTaskbar   =   0   'False
   Begin VB.ListBox lstNom 
      Height          =   2790
      Left            =   240
      TabIndex        =   10
      Top             =   1680
      Width           =   2535
   End
   Begin VB.Frame fraVehicule 
      Caption         =   " V�hicule "
      Height          =   1455
      Left            =   240
      TabIndex        =   6
      Top             =   120
      Width           =   3132
      Begin VB.OptionButton optTypVeh 
         Caption         =   "Bi-articul�"
         Height          =   375
         Index           =   2
         Left            =   240
         TabIndex        =   9
         Top             =   960
         Width           =   1335
      End
      Begin VB.OptionButton optTypVeh 
         Caption         =   "Articul�"
         Height          =   375
         Index           =   1
         Left            =   240
         TabIndex        =   8
         Top             =   600
         Width           =   1215
      End
      Begin VB.OptionButton optTypVeh 
         Caption         =   "Simple"
         Height          =   375
         Index           =   0
         Left            =   240
         TabIndex        =   7
         Top             =   240
         Width           =   1215
      End
   End
   Begin VB.PictureBox picBoutons 
      Align           =   4  'Align Right
      BorderStyle     =   0  'None
      Height          =   4860
      Left            =   3885
      ScaleHeight     =   4860
      ScaleWidth      =   1575
      TabIndex        =   0
      Top             =   0
      Width           =   1575
      Begin VB.CommandButton cmdHelp 
         Caption         =   "Aide"
         Height          =   320
         Left            =   240
         TabIndex        =   5
         Top             =   2160
         Width           =   1215
      End
      Begin VB.CommandButton cmdAction 
         Caption         =   "&Cr�er..."
         Height          =   320
         Index           =   0
         Left            =   240
         TabIndex        =   4
         Top             =   240
         Width           =   1215
      End
      Begin VB.CommandButton cmdTerminer 
         Cancel          =   -1  'True
         Caption         =   "&Terminer"
         Height          =   320
         Left            =   240
         TabIndex        =   3
         Top             =   1680
         Width           =   1215
      End
      Begin VB.CommandButton cmdAction 
         Caption         =   "&Supprimer"
         Enabled         =   0   'False
         Height          =   320
         Index           =   2
         Left            =   240
         TabIndex        =   2
         Top             =   1200
         Width           =   1215
      End
      Begin VB.CommandButton cmdAction 
         Caption         =   "&Modifier..."
         Enabled         =   0   'False
         Height          =   320
         Index           =   1
         Left            =   240
         TabIndex        =   1
         Top             =   720
         Width           =   1215
      End
   End
End
Attribute VB_Name = "frmBibV�hicule"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'**************************************************************************************
'     GIRATION v3 - CERTU/CETE de l'Ouest
'         Septembre 97

'   R�alisation : Andr� VIGNAUD

'   Module de feuille : frmBibV�hicule   -   BIBVEH.FRM
'   Feuille d'accueil de la Biblioth�que de V�hicules (frmV�hicul)

'**************************************************************************************
Option Explicit
Private numFichVeh As Integer
Public Modif As Boolean
Private DrapeauBibliVide As Boolean
Private mV�hicule As VEHICULE
Private mTypeVeh As String ' "S", "A", ou "V" pour Simple, Articul�, Bi-articul�
Public ChargementEnCours As Boolean

Private Sub ActiverBoutons()
  
  If mV�hicule Is Nothing Then
    Me.cmdAction(1).Enabled = False
    Me.cmdAction(2).Enabled = False
  Else
    Me.cmdAction(1).Enabled = True
    Me.cmdAction(2).Enabled = Not mV�hicule.Prot�g�
    If EnVisu Then
      Me.cmdAction(1).Caption = ID_Visualiser
      Me.cmdAction(2).Enabled = False
    Else
      Me.cmdAction(1).Caption = ID_Modifier
      Me.cmdAction(2).Enabled = True
    End If
  End If
End Sub

Public Function EnVisu() As Boolean

  If gtBibliVerrouill�e Then
    EnVisu = True
  Else
    If mV�hicule Is Nothing Then
      EnVisu = True
    Else
      EnVisu = mV�hicule.Prot�g�
    End If
  End If
  
End Function

'********************************************************************************
'Choix d'une action :  Cr�er, Modifier, Supprimer un v�hicule
'********************************************************************************
Private Sub cmdAction_Click(Index As Integer)
Dim LectureSeule As Boolean
Dim OuvrirVeh As Boolean
Dim unV�hicule As VEHICULE

  Select Case Index
  Case 0
    Set unV�hicule = DemandeNomV�hic
    If Not unV�hicule Is Nothing Then
      Set mV�hicule = unV�hicule
      OuvrirVeh = True
      Me.optTypVeh(unV�hicule.nbRemorque) = True
    End If
    
  Case 1

    OuvrirVeh = True
  
  Case 2
    'Supprimer un v�hicule
    If MsgBox(ID_Supprimer & " " & mV�hicule.Nom & " ?", vbYesNo + vbExclamation + vbDefaultButton2, IDm_ConfirmSuppr) = vbYes Then
      SupprimerV�hicule
      Set mV�hicule = Nothing
      mTypeVeh = ""
      ActiverBoutons
    End If

  End Select
  
  If OuvrirVeh Then
  'Cr�er,Modifier ou Visualiser un v�hicule
    If Not EnVisu Then
      'V�rifier l'autorisation de mise � jour
      Close numFichVeh
      If BibliEnMiseAJour Then
        LectureSeule = True
      Else
      ' Verrouilage de la biblioth�que en �criture
        numFichVeh = FreeFile
        Open GirationVeh For Random Lock Write As numFichVeh
      End If
    End If
    
    If Not LectureSeule Then
      With frmV�hicule
        If .contextBibliVeh Then  ' Biblioth�que en cours d'utilisation : la feuille est simplement cach�e
          Unload frmV�hicule
        Else
          .contextBibliVeh = True
        End If
        .Show vbModal
        If Not ExistVeh(mV�hicule.Nom, ColV�hicules) Then
          'abandon de la cr�ation
          Set mV�hicule = Nothing
          mTypeVeh = ""
        End If
      End With
    End If
  End If
  
End Sub

Public Sub AjouterV�hicule(ByVal unV�hicule As VEHICULE)

On Error GoTo GestErr

  If Not unV�hicule Is Nothing Then
    Set mV�hicule = unV�hicule
    optTypVeh_Click Numopt(optTypVeh)
  End If
Exit Sub
GestErr:
  If Err <> ErrV�hicule Then
    ErreurNonFatale "BibV�hicule.Ajouter"
  End If
  Err.Raise ErrV�hicule
End Sub

Public Sub RenommerV�hicule(ByVal unV�hicule As VEHICULE)
  
On Error GoTo GestErr
  
  If Not unV�hicule Is Nothing Then
    SupprimerV�hicule
    AjouterV�hicule unV�hicule
  End If

Exit Sub
GestErr:
  If Err <> ErrV�hicule Then
    ErreurNonFatale "BibV�hicule.Renommer"
  End If
  Err.Raise ErrV�hicule
End Sub

Private Sub SupprimerV�hicule()
  ColV�hicules.Remove UCase(mV�hicule.Nom)
  lstNom.RemoveItem Me.lstNom.ListIndex
  If Not VersionDemo Then Modif = True
End Sub

Private Function DemandeNomV�hic() As VEHICULE
Dim NumOptTyp As Integer

  With frmNewVehicule
    NumOptTyp = Numopt(optTypVeh)
    If NumOptTyp <> -1 Then
      .optTypVeh(NumOptTyp).Value = True
    End If
    .Show vbModal, Me
    If .ValidOK Then
      .ValidOK = False
      
      Set DemandeNomV�hic = New VEHICULE
      DemandeNomV�hic.Nom = Trim(.txtNom.Text)
      Select Case Numopt(.optTypVeh)
      Case 0
        mTypeVeh = Left(ID_Simple, 1)
        DemandeNomV�hic.nbRemorque = 0
      Case 1
        mTypeVeh = Left(ID_Articul�, 1)
        DemandeNomV�hic.nbRemorque = 1
      Case 2
        mTypeVeh = Left(ID_BiArticul�, 1)
        DemandeNomV�hic.nbRemorque = 2
      End Select
    End If
  End With
  
  Unload frmNewVehicule
  
End Function

Private Sub cmdTerminer_Click()

Dim VehicTab As StructV�hicule
Dim Vehic As VEHICULE
Dim i As Integer

  Unload Me   ' D�charge �galement frmV�hicule �ventuellement cach�e

  If Modif Then  ' Enregistrement de la biblioth�que
    Modif = False
    
    If Not BibliEnMiseAJour Then
      If ExistFich(GirationVeh) Then Kill GirationVeh
      numFichVeh = FreeFile
      Open GirationVeh For Random Lock Read Write As numFichVeh Len = Len(VehicTab)
      Put #numFichVeh, 1, vehicVersion
        For Each Vehic In ColV�hicules
          'Mise au format StructV�hicule l'objet V�hicule
          ConvObjetStruct Vehic, VehicTab
          'Ecriture du v�hicule dans le fichier
          i = i + 1
          Put #numFichVeh, i + 1, VehicTab
        Next
      Close numFichVeh
    End If

  End If

End Sub

Private Sub Form_Activate()
  If ChargementEnCours Then
    ChargementEnCours = False
  End If
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
  If Modif And UnloadMode = vbFormControlMenu Then
    Cancel = (MsgBox("Abandonner les modifications de la biblioth�que" & vbCrLf & vbCrLf, vbYesNo + vbQuestion + vbDefaultButton2, IDm_Confirmation)) = vbNo
  End If
End Sub


Private Sub Form_Unload(Cancel As Integer)

      If frmV�hicule.contextBibliVeh Then ' La feuille frmV�hicule est encore charg�e
        Unload frmV�hicule
        frmV�hicule.contextBibliVeh = False
      End If
      Close numFichVeh
      gtBibliVerrouill�e = False
      If DrapeauBibliVide And ColV�hicules.Count = 0 Then Kill GirationVeh

End Sub

Public Sub VehDelete()
  cmdAction(2) = True
End Sub

Private Sub Form_Load()
Dim i As Integer
Dim Vehic As VEHICULE

On Error GoTo GestErr
     
  ChargementEnCours = True
  
  If BibliEnMiseAJour(premier:=True) Then
    Me.cmdAction(0).Enabled = False
    
  Else
    ' Verrouilage de la biblioth�que en �criture
    DrapeauBibliVide = Not ExistFich(GirationVeh)
    numFichVeh = FreeFile
    Open GirationVeh For Random Lock Write As numFichVeh
  End If

  'Affichage centr� de la fen�tre
  Me.ScaleMode = vbTwips
  Me.Left = (Screen.Width - Me.Width) / 2
  Me.Top = (Screen.Height - Me.Height) / 2

'  optTypVeh(0) = True

   ' Aide en ligne contexte
   Me.HelpContextID = BIBVEHICUL

Exit Sub

GestErr:
    ErrGeneral

End Sub

Private Sub cmdHelp_Click()
  
  SendKeys "{F1}", True
  
End Sub

Public Property Get V�hicule() As VEHICULE
  Set V�hicule = mV�hicule
End Property

Public Property Let V�hicule(ByVal vNewValue As VEHICULE)
  Set mV�hicule = vNewValue
End Property


Private Sub lstNom_Click()
Dim i As Integer

  Set mV�hicule = ColV�hicules(UCase(lstNom.Text))

  cmdAction(1).Enabled = True
  With mV�hicule
    If .Prot�g� Or gtBibliVerrouill�e Then 'Or .nbUtilisation > 0 Then
      cmdAction(1).Caption = ID_Visualiser & "..."
      cmdAction(2).Enabled = False
    Else
      cmdAction(1).Caption = ID_Modifier & "..."
      cmdAction(2).Enabled = True
    End If
 
    optTypVeh(.nbRemorque) = True
  End With
  
  ' G�rer l'activit� des boutons en fonction du choix
  ActiverBoutons

End Sub

Private Sub lstNom_DblClick()
  If cmdAction(1).Enabled Then cmdAction(1).Value = True
End Sub

Private Sub optTypVeh_Click(Index As Integer)
Dim i As Integer

      ' Liste des v�hicules
    With lstNom
      Me.lstNom.Clear
      For i = 1 To ColV�hicules.Count
        If ColV�hicules(i).nbRemorque = Index Then
          .AddItem Trim(ColV�hicules(i).Nom)
          If Not mV�hicule Is Nothing Then
            If mV�hicule.Nom = Trim(ColV�hicules(i).Nom) Then
              .ListIndex = .ListCount - 1
            End If
          End If
        End If
      Next
      
    End With

End Sub
