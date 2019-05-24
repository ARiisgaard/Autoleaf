#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; This stores settings (which file to open) one the computer - this is run when the program is run for the first time
; IniRead, Project, %A_ScriptFullPath%:Stream:$DATA, Settings, Pass,error
; If (Project="error")
;  {
;  InputBox, Project , New, Enter the overleaf address,
;  IniWrite, %Project%, %A_ScriptFullPath%:Stream:$DATA, Settings, Pass
;  }
; else {
;    Run %Project%
;  }

; These are the hotkey <^>! means AltGr
<^>!F1::This_Hotkey("Guide")

<^>!f::This_Hotkey("Figure")

<^>!m::This_Hotkey("Minipage")

<^>!t::This_Hotkey("Tabular")

<^>!l::This_Hotkey("Source")

<^>!r::This_Hotkey("Reload")

<^>!F2::This_Hotkey("SetProject")



This_Hotkey(key) {

;This resets the project folder
	; if (key = "SetProject") {
	; 	InputBox, Project , New, Enter the overleaf address,
	;   IniWrite, %Project%, %A_ScriptFullPath%:Stream:$DATA, Settings, Pass
	; }

;This reloads the project - used for easily testing changes to the program
	if (key = "Reload") {
Reload
	}

; This shows the user the possible hotkeys
if (key = "Guide") {

	MsgBox,

	(
Overview of shortcuts:

AltGr + F = figure
AltGr + M = Minipage
AltGr + T = "Fake" tabular
AltGr + L = Litteratur
AltGr + F2 = Change project path

	)

}

; This is used for adding a source
if (key = "Source") {

	InputBox, SourceKey, Autoleaf Sourcer, Enter a key (no special characters),
	if (RegExmatch(SourceKey, "[^[:ascii:]]|\#|\%|=|\040"))
		{
		MsgBox, Special characters detected.
		Return
		}
	if (ErrorLevel)
	    {
			Return
		}

	InputBox, SourceTitle, Autoleaf Sourcer, Enter the title,
	if (ErrorLevel)
	    {
			Return
		}
	InputBox, SourceAuthor, Autoleaf Sourcer, Enter the author(s) `n (Seperate multiple authors with "and". `n Inclose company names in braces `n eg. {Aalborg University}),
	if (ErrorLevel)
			{
			Return
		}
	InputBox, SourceAddress, Autoleaf Sourcer, Enter the webaddress,
	if (ErrorLevel)
			{
			Return
		}
	InputBox, SourceYear, Autoleaf Sourcer, Enter the year,
	if (ErrorLevel)
			{
			Return
		}

SourceTime = Last Accessed: %A_DD%-%A_MM%-%A_YYYY%.


clipboard  =
(
@MANUAL {%SourceKey%,
  title = "%SourceTitle%",
  author = "%SourceAuthor%",
  address = "\url{%SourceAddress%}",
  year = "%SourceYear%",
  note = "%SourceTime%"
}
)
ClipWait, 2
if (!ErrorLevel)         ; If NOT ErrorLevel, ClipWait found data on the clipboard
    Send, ^v             ; paste the text






	}

;This is used to add a figure
if (key = "Figure") {

InputBox, FigureName, Autoleaf Figure, Enter the figure name,
if (ErrorLevel)
		{
		Return
	}
InputBox, FigureText, Autoleaf Figure, Enter the caption,
if (ErrorLevel)
		{
		Return
	}

	clipboard  =
	(
\begin{figure} [H]
	\centering
	\includegraphics[width=.8\textwidth]{Pictures/%FigureName%}
	\caption{%FigureText%}
	\label{%FigureName%}
\end{figure}
	)
	ClipWait, 2
	if (!ErrorLevel)         ; If NOT ErrorLevel, ClipWait found data on the clipboard
	    Send, ^v             ; paste the text

Return
}

; This is used for adding a "minipage" - two figures next to each other
if (key = "Minipage"){

InputBox, Figure1Name, Autoleaf Minipage, Enter the first figure name,
if (ErrorLevel)
		{
		Return
	}
InputBox, Figure1Text, Autoleaf Minipage, Enter the first caption,
if (ErrorLevel)
		{
		Return
	}
InputBox, Figure2Name, Autoleaf Minipage, Enter the second figure name,
if (ErrorLevel)
		{
		Return
	}
InputBox, Figure2Text, Autoleaf Minipage, Enter the second caption,
if (ErrorLevel)
		{
		Return
	}


	clipboard  =
	(
\begin{figure} [h]
	\begin{minipage}[t]{0.45\textwidth}
		\centering
		\includegraphics[width=1\textwidth]{Pictures/%Figure1Name%}
		\caption{%Figure1Text%}
		\label{%Figure1Name%}
	\end{minipage}
	\hspace{0.1\textwidth}
	\begin{minipage}[t]{0.45\textwidth}
		\centering
		\includegraphics[width=1\textwidth]{Pictures/%Figure2Name%}
		\caption{%Figure2Text%}
		\label{%Figure2Name%}
	\end{minipage}
\end{figure}
	)
	ClipWait, 2
	if (!ErrorLevel)         ; If NOT ErrorLevel, ClipWait found data on the clipboard
	    Send, ^v             ; paste the text



Return
}

; This is used for adding a tabular
if (key = "Tabular"){

	InputBox, TabName, Autoleaf Tabular, Enter the tabular name,
	if (ErrorLevel)
			{
			Return
		}
	InputBox, TabText, Autoleaf Tabular, Enter the caption,
	if (ErrorLevel)
			{
			Return
		}

	clipboard  =
	(
\begin{table}[htbp]
  \centering
  \begin{tabular}{l}
  \includegraphics[width=0.8\textwidth]{Pictures/%TabName%}
  \end{tabular}
  \caption{%TabText%}
  \label{%TabName%}
\end{table}
	)
	ClipWait, 2
	if (!ErrorLevel)         ; If NOT ErrorLevel, ClipWait found data on the clipboard
	    Send, ^v             ; paste the text


Return
}

}
