%% smartcross.cls – document class for "Crossing at a Red Light – Smart Pedestrian Crossing"
%% Group shirloma · Generative AI course (Dr. Yoram Segal, Bar-Ilan University)
%%
%% ALL formatting lives here (PLAN §5). Chapter files contain content + template commands only.
%% Tested toolchain: TeX Live 2026 (LuaHBTeX 1.24.0, babel v26.4, biber 2.21).
%% Compile from the REPOSITORY ROOT (fonts are loaded by relative path from fonts/).
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{smartcross}[2026/11/23 v0.1 Smart Crosswalk report class (shirloma)]
\def\SmartCrossVersion{0.1}

%% ---------------------------------------------------------------- engine guard (qa-cls-version)
\ifdefined\directlua\else
  \ClassError{smartcross}{This class needs LuaLaTeX}{Compile with lualatex (TeX Live 2026).}
\fi
\ifnum\luatexversion<124
  \ClassError{smartcross}{LuaTeX engine too old (\the\luatexversion; need >= 124)}%
    {Use TeX Live 2026 (/Library/TeX/texbin). MiKTeX 22.1 for macOS is not supported (README).}
\fi

\LoadClass[11pt,a4paper,oneside]{report}

%% ---------------------------------------------------------------- page geometry
\RequirePackage[a4paper,top=31mm,bottom=28mm,left=24mm,right=24mm,
  headheight=9mm,headsep=8mm,footskip=14mm]{geometry}

%% ---------------------------------------------------------------- languages / BiDi
\RequirePackage[english,bidi=basic,layout=tabular]{babel}% NOT layout=counters: it reverses 4.1 -> 1.4 under bidi=basic
\babelprovide[import,main]{hebrew}
\@ifpackagelater{babel}{2026/03/01}{}{%
  \ClassWarningNoLine{smartcross}{babel older than v26.4: tested toolchain is TeX Live 2026}}

%% ---------------------------------------------------------------- fonts (bundled OFL Noto, PRD §6.2)
%% Noto Hebrew fonts contain ONLY Hebrew glyphs: digits, Latin and punctuation come from a
%% luaotfload fallback to the matching Latin family (INC-001).
\directlua{
  luaotfload.add_fallback("schebrm",   {"[fonts/NotoSerif/NotoSerif-Regular.otf]:mode=harf;"})
  luaotfload.add_fallback("schebrmbf", {"[fonts/NotoSerif/NotoSerif-Bold.otf]:mode=harf;"})
  luaotfload.add_fallback("schebsf",   {"[fonts/NotoSans/NotoSans-Regular.otf]:mode=harf;"})
  luaotfload.add_fallback("schebsfbf", {"[fonts/NotoSans/NotoSans-Bold.otf]:mode=harf;"})
}
\newcommand\sc@fontpath[1]{Path=fonts/#1/, Extension=.otf}
\babelfont{rm}[\sc@fontpath{NotoSerif}, UprightFont=*-Regular, BoldFont=*-Bold,
  ItalicFont=*-Italic, BoldItalicFont=*-BoldItalic]{NotoSerif}
\babelfont{sf}[\sc@fontpath{NotoSans}, UprightFont=*-Regular, BoldFont=*-Bold,
  ItalicFont=*-Italic, BoldItalicFont=*-BoldItalic]{NotoSans}
\babelfont{tt}[\sc@fontpath{NotoSansMono}, UprightFont=*-Regular, BoldFont=*-Bold,
  Scale=0.92]{NotoSansMono}
\babelfont[hebrew]{rm}[\sc@fontpath{NotoSerifHebrew}, UprightFont=*-Regular, BoldFont=*-Bold,
  UprightFeatures={RawFeature={fallback=schebrm}},
  BoldFeatures={RawFeature={fallback=schebrmbf}}]{NotoSerifHebrew}
\babelfont[hebrew]{sf}[\sc@fontpath{NotoSansHebrew}, UprightFont=*-Regular, BoldFont=*-Bold,
  UprightFeatures={RawFeature={fallback=schebsf}},
  BoldFeatures={RawFeature={fallback=schebsfbf}}]{NotoSansHebrew}
\RequirePackage{amsmath}
\setmathrm{NotoSerif}[\sc@fontpath{NotoSerif}, UprightFont=*-Regular, BoldFont=*-Bold,
  ItalicFont=*-Italic]

\linespread{1.15}
\setlength\parindent{0pt}
\setlength\parskip{5pt plus 2pt minus 1pt}
\emergencystretch=1.5em

%% ---------------------------------------------------------------- colour tokens (PRD §6.1)
\RequirePackage[table]{xcolor}
\definecolor{Asphalt}{HTML}{2E3338}
\definecolor{AsphaltLight}{HTML}{5A6068}
\definecolor{SignalRed}{HTML}{C8102E}
\definecolor{SignalAmber}{HTML}{F2A900}
\definecolor{SignalGreen}{HTML}{00843D}
\definecolor{StripeWhite}{HTML}{F4F4F2}
\definecolor{Paper}{HTML}{FFFFFF}
\colorlet{LampRedOff}{SignalRed!22!black}
\colorlet{LampAmberOff}{SignalAmber!22!black}
\colorlet{LampGreenOff}{SignalGreen!22!black}
\colorlet{HousingBlack}{black!88}
\pagecolor{Paper}

%% ---------------------------------------------------------------- packages
\RequirePackage{graphicx}
\RequirePackage{tikz}
\usetikzlibrary{calc,shapes.geometric}
\RequirePackage[most]{tcolorbox}
\RequirePackage{booktabs,array,tabularx}
\RequirePackage{fancyhdr}
\RequirePackage{enumitem}
\setlist{itemsep=2pt,topsep=4pt}
\RequirePackage{caption}
\DeclareCaptionFont{scasphalt}{\color{Asphalt}}
\captionsetup{font={small,sf},labelfont={bf,scasphalt},labelsep=colon,skip=6pt}
\captionsetup[table]{position=top}
\RequirePackage{csquotes}
\DeclareQuoteStyle{hebrew}{\textquotedblright}{\textquotedblright}{\textquoteright}{\textquoteright}% Hebrew: ”…” 
\RequirePackage[backend=biber,style=ieee,language=english,autolang=none]{biblatex}% language handled by the .cls (\cite wrapper, \printreferences); autolang=other leaks \babel@toc{english} into the TOC
\RequirePackage[hidelinks,bookmarksnumbered,pdfencoding=auto]{hyperref}

%% ---------------------------------------------------------------- BiDi template commands (PRD §7)
%% Only these commands may be used for direction control in chapter files.
\DeclareRobustCommand\en[1]{\foreignlanguage{english}{#1}}      % English word/phrase, one unit
\DeclareRobustCommand\num[1]{\leavevmode\hbox dir TLT{#1}}         % number/version/date, one LTR unit
\DeclareRobustCommand\pct[1]{\num{#1\%}}                           % percentage: \pct{13.5}
\DeclareRobustCommand\range[2]{\num{#1\textendash#2}}              % range: \range{0.51}{0.78}
\DeclareRobustCommand\unit[2]{\num{#1\,#2}}                        % value + unit: \unit{30}{s}
\DeclareRobustCommand\hebmath[1]{\text{\foreignlanguage{hebrew}{#1}}} % Hebrew inside math
\newenvironment{ltrblock}{\par\pardir TLT\textdir TLT}{\par}        % diagrams, code (LTR frame)
\newcommand\sc@ltr[1]{\hbox dir TLT{#1}}                           % internal: LTR picture box
\newcommand\sc@ltrcenter[1]{\hbox dir TLT to\linewidth{\hss#1\hss}}  % internal: centred LTR picture
%% TikZ draws in LTR coordinates; Hebrew node text must be set RTL explicitly (style 'rtl').
\tikzset{rtl/.style={execute at begin node={\pardir TRT\textdir TRT}}}

%% ---------------------------------------------------------------- document metadata
\newcommand\sc@title{}\newcommand\sc@subtitle{}\newcommand\sc@entitle{}
\newcommand\sc@authors{}\newcommand\sc@course{}\newcommand\sc@lecturer{}
\newcommand\sc@institution{}\newcommand\sc@docdate{}\newcommand\sc@group{shirloma}
\newcommand\sc@footertitle{}
\newcommand\Title[1]{\renewcommand\sc@title{#1}}
\newcommand\Subtitle[1]{\renewcommand\sc@subtitle{#1}}
\newcommand\EnglishTitle[1]{\renewcommand\sc@entitle{#1}}
\newcommand\Authors[1]{\renewcommand\sc@authors{#1}}
\newcommand\Course[1]{\renewcommand\sc@course{#1}}
\newcommand\Lecturer[1]{\renewcommand\sc@lecturer{#1}}
\newcommand\Institution[1]{\renewcommand\sc@institution{#1}}
\newcommand\DocDate[1]{\renewcommand\sc@docdate{#1}}
\newcommand\GroupCode[1]{\renewcommand\sc@group{#1}}
\newcommand\FooterTitle[1]{\renewcommand\sc@footertitle{#1}}

%% ---------------------------------------------------------------- crosswalk-stripe rule (PRD §6.3)
%% \crosswalkrule[height]  – asphalt bar with white zebra stripes across the line width
\newcommand\sc@zebra[2]{% #1 width (dimen), #2 height (dimen)
  \begin{tikzpicture}[x=1pt,y=1pt]
    \pgfmathsetmacro\sc@w{#1}\pgfmathsetmacro\sc@h{#2}
    \fill[Asphalt] (0,0) rectangle (\sc@w,\sc@h);
    \pgfmathtruncatemacro\sc@n{floor((\sc@w-2)/(\sc@h*2.4))}
    \foreach \i in {0,...,\sc@n}{
      \fill[StripeWhite] ({1.5+\i*\sc@h*2.4},{\sc@h*0.2}) rectangle ++({\sc@h*1.2},{\sc@h*0.6});}
  \end{tikzpicture}}
\newcommand\crosswalkrule[1][2.6mm]{%
  \par\vspace{4pt}\noindent\sc@ltr{\sc@zebra{\linewidth}{#1}}\par\vspace{4pt}}

%% ---------------------------------------------------------------- traffic-light pieces
%% \sc@trafficlight{red|amber|green|off} – vertical 3-lamp signal head
\newcommand\sc@trafficlight[1]{%
  \begin{tikzpicture}
    \edef\sc@ph{#1}
    \fill[HousingBlack,rounded corners=2.2mm] (0,0) rectangle (10mm,27mm);
    \draw[StripeWhite,line width=0.6pt,rounded corners=2.2mm] (0,0) rectangle (10mm,27mm);
    \def\sc@lamp##1##2##3{% name, y, colour
      \edef\sc@test{##1}%
      \ifx\sc@test\sc@ph
        \fill[##3,opacity=0.35] (5mm,##2) circle (4.1mm);
        \fill[##3] (5mm,##2) circle (3.1mm);
      \else
        \fill[##3!22!black] (5mm,##2) circle (3.1mm);
      \fi}
    \sc@lamp{red}{21mm}{SignalRed}
    \sc@lamp{amber}{13.5mm}{SignalAmber}
    \sc@lamp{green}{6mm}{SignalGreen}
  \end{tikzpicture}}
%% small lamp icon used in box titles
\newcommand\sc@lampicon[1]{\tikz[baseline=-0.6ex]{\fill[#1] (0,0) circle (1.25mm);
  \draw[StripeWhite,line width=0.5pt] (0,0) circle (1.25mm);}}
%% pedestrian "red man" icon used in the scene box
\newcommand\sc@pedestrianicon{%
  \begin{tikzpicture}[x=1mm,y=1mm]
    \fill[HousingBlack,rounded corners=1.2mm] (0,0) rectangle (9,11);
    \fill[SignalRed] (4.5,8.6) circle (0.95);
    \fill[SignalRed,rounded corners=0.5mm] (3.2,4.2) rectangle (5.8,7.4);
    \draw[SignalRed,line width=1.1pt,line cap=round] (3.3,7.0) -- (2.6,4.6) (5.7,7.0) -- (6.4,4.6)
      (3.9,4.4) -- (3.8,1.6) (5.1,4.4) -- (5.2,1.6);
  \end{tikzpicture}}

%% ---------------------------------------------------------------- chapter phase (lamp) and sign
%% ch. 1–3 red (the problem) · 4–7 amber (analysis & design) · 8+ green (ready to implement)
\let\sc@lampoverride\@empty
\newcommand\SetLamp[1]{\gdef\sc@lampoverride{#1}}        % one-off override for the next chapter
\gdef\sc@signshape{square}
\newcommand\SetSign[1]{\gdef\sc@signshape{#1}}           % square (default) | triangle (warning)
\newcommand\sc@computelamp{%
  \ifx\sc@lampoverride\@empty
    \ifnum\c@chapter<4 \def\sc@lampnow{red}\else
      \ifnum\c@chapter<8 \def\sc@lampnow{amber}\else\def\sc@lampnow{green}\fi\fi
  \else\let\sc@lampnow\sc@lampoverride\fi
  \global\let\sc@lampoverride\@empty}

%% ---------------------------------------------------------------- chapter opener (road sign band)
\newlength\sc@bandh \setlength\sc@bandh{34mm}
\newcommand\sc@badge[1]{% #1 = number
  \def\sc@tri{triangle}%
  \ifx\sc@signshape\sc@tri
    \node[regular polygon,regular polygon sides=3,minimum size=27mm,fill=StripeWhite,
      draw=SignalRed,line width=2.4pt,rounded corners=1.5mm] (badge) at (\textwidth-15mm,15.5mm) {};
    \node[text=Asphalt,font=\sffamily\bfseries\fontsize{24}{24}\selectfont] at (\textwidth-15mm,12.5mm) {#1};
  \else
    \fill[Asphalt] (\textwidth-27mm,5mm) rectangle (\textwidth-3mm,29mm);
    \draw[StripeWhite,line width=1.6pt,rounded corners=2.5mm] (\textwidth-26mm,6mm) rectangle (\textwidth-4mm,28mm);
    \node[rtl,text=StripeWhite,font=\sffamily\small] at (\textwidth-15mm,23.5mm) {פרק};
    \node[text=StripeWhite,font=\sffamily\bfseries\fontsize{28}{28}\selectfont] at (\textwidth-15mm,13.5mm) {#1};
  \fi}
\newcommand\sc@chapterband[2]{% #1 number (may be empty), #2 title
  \noindent\sc@ltr{%
  \begin{tikzpicture}
    \useasboundingbox (0,0) rectangle (\textwidth,\sc@bandh);
    \fill[Asphalt,rounded corners=3mm] (0,0) rectangle (\textwidth,\sc@bandh);
    \ifx\relax#1\relax\else\sc@badge{#1}\fi
    \node[rtl,anchor=east,text=StripeWhite,font=\sffamily\bfseries\LARGE,
      text width=\textwidth-56mm,align=flush right] at (\textwidth-\ifx\relax#1\relax 8mm\else 32mm\fi,17mm) {#2};
    \node[anchor=west] at (6mm,17mm) {\sc@trafficlight{\ifx\relax#1\relax off\else\sc@lampnow\fi}};
  \end{tikzpicture}}\par
  \vspace{2mm}\noindent\sc@ltr{\sc@zebra{\textwidth}{2.6mm}}\par}
\renewcommand\@makechapterhead[1]{%
  \sc@computelamp
  \vspace*{-6mm}\sc@chapterband{\thechapter}{#1}\vspace{9mm}}
\renewcommand\@makeschapterhead[1]{%
  \vspace*{-6mm}\sc@chapterband{}{#1}\vspace{9mm}}
\renewcommand\chaptermark[1]{\markboth{פרק \thechapter{} · #1}{}}

%% ---------------------------------------------------------------- sections
\renewcommand\section{\@startsection{section}{1}{\z@}{-3.2ex plus -1ex minus -.2ex}%
  {1.2ex plus .2ex}{\sffamily\Large\bfseries\color{Asphalt}}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}{-2.6ex plus -1ex minus -.2ex}%
  {0.8ex plus .2ex}{\sffamily\large\bfseries\color{Asphalt}}}
\renewcommand\@seccntformat[1]{{\color{SignalRed}\csname the#1\endcsname}\hspace{0.7em}}
\setcounter{tocdepth}{2}
\setcounter{secnumdepth}{2}

%% ---------------------------------------------------------------- header banner + footer (PRD §6.3)
\newcommand\sc@headbanner{%
  \sc@ltr{\begin{tikzpicture}
    \useasboundingbox (0,0) rectangle (\headwidth,6.5mm);
    \fill[Asphalt,rounded corners=1.5mm] (0,0) rectangle (\headwidth,6.5mm);
    \foreach \i in {0,...,7}{\fill[StripeWhite] (30mm+\i*4.4mm,1.2mm) rectangle ++(2.2mm,4.1mm);}
    \node[anchor=west,text=StripeWhite,font=\sffamily\scriptsize\bfseries] at (3mm,3.25mm) {\sc@group};
    \node[rtl,anchor=east,text=StripeWhite,font=\sffamily\footnotesize] at (\headwidth-3mm,3.25mm) {\leftmark};
  \end{tikzpicture}}}
\newcommand\sc@footer{%
  \sc@ltr{\begin{tikzpicture}
    \useasboundingbox (0,0) rectangle (\headwidth,7mm);
    \node[anchor=west,text=Asphalt,font=\sffamily\small\bfseries] at (0,1.5mm) {\thepage};
    \node[rtl,anchor=east,text=AsphaltLight,font=\sffamily\scriptsize] at (\headwidth,1.5mm)
      {\sc@footertitle~·~\en{\sc@group}~\num{©\,2026}};
    \fill[Asphalt] (0,5.4mm) rectangle (\headwidth,6.3mm);
    \begin{scope}\clip (0.5mm,5.4mm) rectangle (\headwidth-0.5mm,6.3mm);
      \foreach \i in {0,...,45}{\fill[StripeWhite] (1mm+\i*4.2mm,5.6mm) rectangle ++(2.1mm,0.5mm);}
    \end{scope}
  \end{tikzpicture}}}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[C]{\sc@headbanner}
\fancyfoot[C]{\sc@footer}
\renewcommand\headrulewidth{0pt}
\renewcommand\footrulewidth{0pt}
\fancypagestyle{plain}{\fancyhf{}\fancyfoot[C]{\sc@footer}}

%% ---------------------------------------------------------------- front / main matter
\newcommand\FrontMatter{\clearpage\pagenumbering{roman}%
  \renewcommand\thepage{\localecounter{letters}{page}}}
\newcommand\MainMatter{\clearpage\pagenumbering{arabic}}

%% ---------------------------------------------------------------- callout boxes (PRD §6.3)
%% tcolorbox draws its frame with TikZ in LTR coordinates. Each public box environment therefore
%% builds the box in an LTR paragraph and sets title + content RTL (otherwise the frame is shifted
%% off the page in RTL text – defect found in the Step 09 style sample).
\tcbset{sc base/.style={enhanced,breakable,arc=2mm,boxrule=0.9pt,
  left=3.5mm,right=3.5mm,top=2mm,bottom=2mm,toptitle=1.2mm,bottomtitle=1.2mm,
  fonttitle=\sffamily\bfseries\small,coltitle=StripeWhite,
  before skip=9pt,after skip=9pt,parbox=false,
  before upper={\pardir TRT\textdir TRT},before title={\pardir TRT\textdir TRT}}}
\newtcolorbox{sc@findingbox}[1]{sc base,colback=SignalGreen!6,colframe=SignalGreen,
  title={\sc@lampicon{SignalGreen!60!white}~#1}}
\newtcolorbox{sc@cautionbox}[1]{sc base,colback=SignalAmber!12,colframe=SignalAmber,
  coltitle=Asphalt,title={\sc@lampicon{SignalAmber!80!black}~#1}}
\newtcolorbox{sc@trapbox}[1]{sc base,colback=SignalRed!5,colframe=SignalRed,
  title={\sc@lampicon{SignalRed!60!white}~#1}}
\newtcolorbox{sc@definitionbox}[1]{sc base,colback=StripeWhite,colframe=Asphalt,title={#1}}
\newtcolorbox{sc@projectbox}[1]{sc base,colback=AsphaltLight!7,colframe=AsphaltLight,title={#1}}
%% scene box: chapter-opening street scene, max 4 lines (PRD §12)
\newtcolorbox{sc@scenebox}{enhanced,colback=Asphalt,colupper=StripeWhite,boxrule=0pt,arc=2mm,
  left=5mm,right=17mm,top=4.2mm,bottom=4.2mm,fontupper=\sffamily\small,parbox=false,
  before skip=4pt,after skip=12pt,before upper={\pardir TRT\textdir TRT},
  overlay={
    \begin{scope}
      \clip ($(frame.south west)+(2.5mm,0)$) rectangle ($(frame.north east)+(-2.5mm,0)$);
      \foreach \i in {0,...,60}{%
        \fill[StripeWhite,opacity=0.85] ($(frame.north west)+(3mm+\i*4.4mm,-1.1mm)$) rectangle ++(2.2mm,-0.9mm);
        \fill[StripeWhite,opacity=0.85] ($(frame.south west)+(3mm+\i*4.4mm,1.1mm)$) rectangle ++(2.2mm,0.9mm);}
    \end{scope}
    \node[anchor=east] at ($(frame.east)+(-3.5mm,0)$) {\sc@pedestrianicon};
  }}
\newcommand\sc@ltrpar{\par\pardir TLT\textdir TLT}
\newenvironment{findingbox}[1][ממצא מרכזי]{\sc@ltrpar\begin{sc@findingbox}{#1}}{\end{sc@findingbox}\par}
\newenvironment{cautionbox}[1][שימו לב: סוגיה בנתונים]{\sc@ltrpar\begin{sc@cautionbox}{#1}}{\end{sc@cautionbox}\par}
\newenvironment{trapbox}[1][מלכודת]{\sc@ltrpar\begin{sc@trapbox}{#1}}{\end{sc@trapbox}\par}
\newenvironment{definitionbox}[1][הגדרה]{\sc@ltrpar\begin{sc@definitionbox}{#1}}{\end{sc@definitionbox}\par}
\newenvironment{projectbox}[1][בפרויקט הנוכחי]{\sc@ltrpar\begin{sc@projectbox}{#1}}{\end{sc@projectbox}\par}
\newenvironment{scenebox}{\sc@ltrpar\begin{sc@scenebox}}{\end{sc@scenebox}\par}

%% ---------------------------------------------------------------- tables
%% Column 1 is on the right (babel layout=tabular). Use booktabs rules; header row via \thead.
\renewcommand\arraystretch{1.25}
\newcommand\thead[1]{{\sffamily\bfseries\color{Asphalt}#1}}
\AtBeginEnvironment{tabular}{\small}
\AtBeginEnvironment{tabularx}{\small}
\setlength\heavyrulewidth{1.1pt}
\setlength\lightrulewidth{0.5pt}
\arrayrulecolor{Asphalt}

%% ---------------------------------------------------------------- equations
\numberwithin{equation}{chapter}

%% ---------------------------------------------------------------- cover page (PRD §6.3)
\newcommand\sc@coverart{%
  {\begin{tikzpicture}[x=1mm,y=1mm]
    % road
    \fill[Asphalt,rounded corners=4mm] (0,0) rectangle (130,52);
    % curbs
    \fill[AsphaltLight] (0,46) rectangle (130,52);
    \fill[AsphaltLight] (0,0) rectangle (130,6);
    % zebra crossing
    \foreach \i in {0,...,8}{\fill[StripeWhite] (22+\i*9,9) rectangle ++(5,34);}
    % waiting pedestrians on the far curb (a group)
    \foreach \x/\s in {30/1,36/0.9,41/1.05,47/0.95}{
      \fill[StripeWhite] (\x,49.8+\s*1.2) circle (\s*1.1);
      \fill[StripeWhite,rounded corners=0.4mm] (\x-\s*1.05,46.6) rectangle (\x+\s*1.05,49.4+\s*0.4);}
    % signal pole + pedestrian head with countdown
    \fill[black!70] (112,6) rectangle (114,62);
    \fill[HousingBlack,rounded corners=1.5mm] (104,62) rectangle (122,90);
    \draw[StripeWhite,line width=0.5pt,rounded corners=1.5mm] (104,62) rectangle (122,90);
    \begin{scope}[shift={(108.5,77)},scale=1]
      \fill[SignalRed] (4.5,8.6) circle (0.95);
      \fill[SignalRed,rounded corners=0.5mm] (3.2,4.2) rectangle (5.8,7.4);
      \draw[SignalRed,line width=1.1pt,line cap=round] (3.3,7.0) -- (2.6,4.6) (5.7,7.0) -- (6.4,4.6)
        (3.9,4.4) -- (3.8,1.6) (5.1,4.4) -- (5.2,1.6);
    \end{scope}
    \node[text=SignalAmber,font=\sffamily\bfseries\fontsize{20}{20}\selectfont] at (113,69) {12};
  \end{tikzpicture}}}
\newcommand\makecover{%
  \begin{titlepage}
    \thispagestyle{empty}
    \begin{tikzpicture}[remember picture,overlay]
      \draw[Asphalt,line width=3.2pt] ($(current page.north west)+(12mm,-12mm)$)
        rectangle ($(current page.south east)+(-12mm,12mm)$);
      \draw[Asphalt,line width=0.7pt] ($(current page.north west)+(15.5mm,-15.5mm)$)
        rectangle ($(current page.south east)+(-15.5mm,15.5mm)$);
    \end{tikzpicture}%
    \centering
    {\sffamily\large\color{Asphalt}\sc@institution\par}
    \vspace{2mm}{\sffamily\normalsize\color{AsphaltLight}\sc@course\par}
    \vspace{14mm}
    \sc@ltrcenter{\sc@coverart}\par
    \vspace{12mm}
    {\sffamily\bfseries\fontsize{30}{38}\selectfont\color{Asphalt}\sc@title\par}
    \vspace{5mm}
    {\sffamily\Large\color{Asphalt}\sc@subtitle\par}
    \vspace{6mm}
    {\sffamily\bfseries\large\color{StripeWhite}\colorbox{SignalRed}{\hspace{3mm}דוח מכין\hspace{3mm}}\par}
    \vspace{7mm}
    {\large\color{AsphaltLight}\en{\sc@entitle}\par}
    \vfill
    \noindent\sc@ltr{\sc@zebra{\textwidth}{2.2mm}}\par\vspace{5mm}
    {\sffamily\normalsize\color{Asphalt}\sc@authors\par}
    \vspace{2mm}{\sffamily\small\color{AsphaltLight}\sc@lecturer\par}
    \vspace{2mm}{\sffamily\small\color{AsphaltLight}\sc@docdate\par}
    \vspace{4mm}{\sffamily\scriptsize\color{AsphaltLight}\num{©}~\num{2026}~קבוצת~\sc@group.~כל הזכויות שמורות.\par}
  \end{titlepage}}

%% ---------------------------------------------------------------- bibliography
%% Citations are one LTR unit, otherwise the brackets break apart in RTL text ("[,1").
\AtBeginDocument{%
  \let\sc@origcite\cite
  \DeclareRobustCommand\cite{\@ifnextchar[\sc@citeopt\sc@citeplain}}
%% Set in ENGLISH, not just LTR: in a Hebrew LTR box babel still mirrors the brackets ("]1[").
\def\sc@citebox#1{\leavevmode\hbox dir TLT{\foreignlanguage{english}{#1}}}
\def\sc@citeplain#1{\sc@citebox{\sc@origcite{#1}}}
\def\sc@citeopt[#1]{\@ifnextchar[{\sc@citetwo[#1]}{\sc@citeone[#1]}}
\def\sc@citeone[#1]#2{\sc@citebox{\sc@origcite[#1]{#2}}}
\def\sc@citetwo[#1][#2]#3{\sc@citebox{\sc@origcite[#1][#2]{#3}}}
\newcommand\printreferences{%
  \chapter*{מקורות}\addcontentsline{toc}{chapter}{מקורות}\markboth{מקורות}{}%
  \begin{otherlanguage}{english}\setquotestyle{english}\printbibliography[heading=none]\end{otherlanguage}}

\endinput
