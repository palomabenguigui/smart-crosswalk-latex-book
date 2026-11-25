%% smartcross.cls – document class for "Crossing at a Red Light – Smart Pedestrian Crossing"
%% Group shirloma · Generative AI course (Dr. Yoram Segal, Bar-Ilan University)
%%
%% ALL formatting lives here (PLAN §5). Chapter files contain content + template commands only.
%% FINAL DESIGN (v1.0, Step 13): editorial cover, chapter openers, stat tiles, thumb tabs, footer and
%% serif body with a wide outer note margin; engineering-style side-bar boxes and booktabs tables.
%% Tested toolchain: TeX Live 2026 (LuaHBTeX 1.24.0, babel v26.4, biber 2.21).
%% Compile from the REPOSITORY ROOT (fonts are loaded by relative path from fonts/).
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{smartcross}[2026/11/25 v1.6 Smart Crosswalk report class (shirloma)]
\def\SmartCrossVersion{1.5}

%% ---------------------------------------------------------------- engine guard (qa-cls-version)
\ifdefined\directlua\else
  \ClassError{smartcross}{This class needs LuaLaTeX}{Compile with lualatex (TeX Live 2026).}
\fi
\ifnum\luatexversion<124
  \ClassError{smartcross}{LuaTeX engine too old (\the\luatexversion; need >= 124)}%
    {Use TeX Live 2026 (/Library/TeX/texbin). MiKTeX 22.1 for macOS is not supported (README).}
\fi

\ProcessOptions\relax
\LoadClass[11pt,a4paper,oneside]{report}

%% ---------------------------------------------------------------- page grid
%% RTL book: the text starts at the RIGHT margin; the LEFT (end/outer) margin carries margin notes
%% and the thumb tabs at the page edge.

  \RequirePackage[a4paper,top=27mm,bottom=27mm,right=22mm,left=50mm,
    marginparwidth=31mm,marginparsep=7mm,headheight=8mm,headsep=9mm,footskip=13mm]{geometry}


%% ---------------------------------------------------------------- languages / BiDi
\RequirePackage[english,bidi=basic,layout=tabular]{babel}% NOT layout=counters: it reverses 4.1 -> 1.4 (DS-03)
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

%% body text: A = serif (editorial), B = sans (engineering)

\linespread{ 1.18}
\setlength\parindent{0pt}
\setlength\parskip{5.5pt plus 2pt minus 1pt}
\emergencystretch=1.5em
\clubpenalty=10000 \widowpenalty=10000

%% ---------------------------------------------------------------- colour tokens (PRD §6.1)
\RequirePackage[table]{xcolor}
\definecolor{Asphalt}{HTML}{2E3338}
\definecolor{AsphaltDeep}{HTML}{1E2226}
\definecolor{AsphaltLight}{HTML}{5A6068}
\definecolor{SignalRed}{HTML}{C8102E}
\definecolor{SignalAmber}{HTML}{F2A900}
\definecolor{SignalGreen}{HTML}{00843D}
\definecolor{SignalAmberDark}{HTML}{9A6B00}% amber for LINES/TEXT on light backgrounds (≥ 4.5:1 on white; QA-06/11)
\definecolor{StripeWhite}{HTML}{F4F4F2}
\definecolor{Paper}{HTML}{FFFFFF}
\definecolor{Concrete}{HTML}{CFD2D5}
\definecolor{ConcreteJoint}{HTML}{BCC0C4}
\definecolor{Curb}{HTML}{9298A0}
\definecolor{Road}{HTML}{353A40}
\definecolor{Hairline}{HTML}{C9CDD2}
\colorlet{HousingBlack}{black!88}
\pagecolor{Paper}

%% ---------------------------------------------------------------- packages
\RequirePackage{graphicx}
\RequirePackage{tikz}
\usetikzlibrary{calc,shapes.geometric,patterns}
\RequirePackage[most]{tcolorbox}
\RequirePackage{booktabs,array,tabularx}
\RequirePackage{fancyhdr}
\RequirePackage{enumitem}
\setlist{itemsep=2pt,topsep=4pt}
\RequirePackage{caption}
\RequirePackage{csquotes}
\DeclareQuoteStyle{hebrew}{\textquotedblright}{\textquotedblright}{\textquoteright}{\textquoteright}% Hebrew: ”…”
\RequirePackage[backend=biber,style=ieee,language=english,autolang=none]{biblatex}% language handled by the .cls (DS-05)
\RequirePackage[hidelinks,bookmarksnumbered,pdfencoding=auto]{hyperref}

%% ---------------------------------------------------------------- BiDi template commands (PRD §7)
%% Only these commands may be used for direction control in chapter files.
\DeclareRobustCommand\en[1]{\foreignlanguage{english}{\lefthyphenmin=62\righthyphenmin=62 #1}}% English word/phrase, one unit; never hyphenated (DS-11)
\DeclareRobustCommand\num[1]{\leavevmode\hbox dir TLT{#1}}         % number/version/date, one LTR unit (DS-07)
\DeclareRobustCommand\pct[1]{\num{#1\%}}                           % percentage: \pct{13.5}
\DeclareRobustCommand\range[2]{\num{#1\textendash#2}}              % range: \range{0.51}{0.78}
\DeclareRobustCommand\unit[2]{\num{#1\,#2}}                        % value + unit: \unit{30}{s}
\DeclareRobustCommand\hebmath[1]{\text{\foreignlanguage{hebrew}{#1}}} % Hebrew inside math
%% English label: letter-spaced capitals in the sans (typographic hierarchy for English tags)
\DeclareRobustCommand\enlabel[1]{\en{\sffamily\addfontfeatures{LetterSpace=14}\MakeUppercase{#1}}}
%% ltrblock: a diagram/picture built in an explicit LTR box, centred on the line. Setting \pardir alone is not
%% enough – babel resets the paragraph direction from the language, and the picture is mirrored (DS-20).
\newsavebox\sc@ltrbox
\newenvironment{ltrblock}{\par\noindent\begin{lrbox}{\sc@ltrbox}\textdir TLT}%
  {\end{lrbox}\hbox dir TLT to\linewidth{\hss\usebox\sc@ltrbox\hss}\par}
\newcommand\sc@ltr[1]{\hbox dir TLT{#1}}                           % internal: LTR picture box
\newcommand\sc@ltrcenter[1]{\hbox dir TLT to\linewidth{\hss#1\hss}}  % internal: centred LTR picture (DS-08)
%% TikZ draws in LTR coordinates; Hebrew node text must be set RTL explicitly (DS-01).
\tikzset{rtl/.style={execute at begin node={\begin{otherlanguage*}{hebrew}\pardir TRT\textdir TRT},
  execute at end node={\end{otherlanguage*}}}}% Hebrew language too: nodes on English pages (bibliography) need Hebrew fonts

%% ---------------------------------------------------------------- document metadata
\newcommand\sc@title{}\newcommand\sc@subtitle{}\newcommand\sc@entitle{}
\newcommand\sc@authors{}\newcommand\sc@course{}\newcommand\sc@lecturer{}
\newcommand\sc@institution{}\newcommand\sc@docdate{}\newcommand\sc@group{shirloma}
\newcommand\sc@footertitle{}\newcommand\sc@docnumber{SCX-PR-001}\newcommand\sc@revision{0.1}
\newcommand\sc@status{טיוטה}
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
\newcommand\DocNumber[1]{\renewcommand\sc@docnumber{#1}}
\newcommand\DocRevision[1]{\renewcommand\sc@revision{#1}}
\newcommand\DocStatus[1]{\renewcommand\sc@status{#1}}

%% ================================================================ PICTOGRAMS
%% \picto[colour]{pedestrian|walker|signal|sensor|warning|info|camera}  – 1em high, inline, LTR-safe.
\newcommand\picto[2][Asphalt]{\leavevmode\hbox dir TLT{\tikz[x=0.1em,y=0.1em,baseline=-1.2]{%
  \csname sc@picto@#2\endcsname{#1}}}}
\newcommand\sc@picto@pedestrian[1]{%
  \fill[#1] (5,9.1) circle (1.3);
  \fill[#1,rounded corners=0.5] (3.6,3.9) rectangle (6.4,7.5);
  \draw[#1,line width=0.1em,line cap=round] (3.7,7.0)--(2.9,4.3) (6.3,7.0)--(7.1,4.3)
    (4.35,4.0)--(4.15,0.4) (5.65,4.0)--(5.85,0.4);}
\newcommand\sc@picto@walker[1]{% walking figure (WALK / clearance interval)
  \fill[#1] (5.6,9.1) circle (1.3);
  \draw[#1,line width=0.16em,line cap=round] (5.3,7.3)--(4.7,4.2);
  \draw[#1,line width=0.1em,line cap=round] (5.2,6.8)--(7.2,5.4) (5.2,6.8)--(3.4,5.6)
    (4.7,4.2)--(6.8,2.4)--(7.4,0.4) (4.7,4.2)--(3.9,2.2)--(2.4,0.9);}
\newcommand\sc@picto@signal[1]{%
  \fill[#1,even odd rule,rounded corners=0.9] (2.4,-0.2) rectangle (7.6,10.4)
    (5,8.3) circle (1.25) (5,5.1) circle (1.25) (5,1.9) circle (1.25);}
\newcommand\sc@picto@sensor[1]{%
  \fill[#1] (4.1,0) rectangle (5.9,5.0);
  \fill[#1] (5,5.7) circle (1.15);
  \draw[#1,line width=0.085em,line cap=round] (2.4,7.3) arc[start angle=150,end angle=30,radius=3];
  \draw[#1,line width=0.085em,line cap=round] (1.0,8.1) arc[start angle=150,end angle=30,radius=4.6];}
\newcommand\sc@picto@warning[1]{%
  \fill[#1,even odd rule,rounded corners=0.7] (5,10.2)--(10.4,0.4)--(-0.4,0.4)--cycle
    (4.45,3.7) rectangle (5.55,7.3) (5,2.35) circle (0.68);}
\newcommand\sc@picto@info[1]{%
  \fill[#1,even odd rule] (5,5) circle (5) (4.4,1.6) rectangle (5.6,5.9) (5,7.6) circle (0.8);}
\newcommand\sc@picto@camera[1]{%
  \fill[#1,even odd rule,rounded corners=0.8] (0.3,1.2) rectangle (9.7,7.9) (5,4.5) circle (2.3);
  \fill[#1] (3.2,7.6) rectangle (6.8,9.0);
  \fill[#1] (5,4.5) circle (1.3);}

%% ================================================================ PHASES (traffic-light logic)
%% ch. 1–3 red (the problem) · 4–7 amber (analysis & design) · 8+ green (ready to implement)
\newcommand\sc@phaseof[1]{\ifnum#1<4 red\else\ifnum#1<8 amber\else green\fi\fi}
\newcommand\sc@phasecolorof[1]{\ifnum#1<4 SignalRed\else\ifnum#1<8 SignalAmber\else SignalGreen\fi\fi}
\gdef\sc@phase{none}% none | red | amber | green  (current page's phase, for tabs)
\let\sc@lampoverride\@empty
\newcommand\SetLamp[1]{\gdef\sc@lampoverride{#1}}        % one-off override for the next chapter
\gdef\sc@signshape{square}
\newcommand\SetSign[1]{\gdef\sc@signshape{#1}}           % reserved: square | triangle
\newcommand\sc@computelamp{%
  \ifx\sc@lampoverride\@empty \xdef\sc@phase{\sc@phaseof{\c@chapter}}%
  \else\xdef\sc@phase{\sc@lampoverride}\fi
  \global\let\sc@lampoverride\@empty}
\def\sc@ph@red{red}\def\sc@ph@amber{amber}\def\sc@ph@green{green}
\newcommand\sc@phasecolor{\ifx\sc@phase\sc@ph@red SignalRed\else\ifx\sc@phase\sc@ph@amber SignalAmber\else
  \ifx\sc@phase\sc@ph@green SignalGreen\else AsphaltLight\fi\fi\fi}
\newcommand\sc@phasename{\ifx\sc@phase\sc@ph@red שלב הבעיה\else\ifx\sc@phase\sc@ph@amber שלב הניתוח והתכן\else
  \ifx\sc@phase\sc@ph@green שלב המימוש\fi\fi\fi}
\newcommand\sc@phaseen{\ifx\sc@phase\sc@ph@red The problem\else\ifx\sc@phase\sc@ph@amber Analysis \& design\else
  \ifx\sc@phase\sc@ph@green Implementation\fi\fi\fi}

%% 3-lamp signal head. \sc@lamps{phase}{v|h}{lamp radius mm}
\newcommand\sc@lamps[3]{%
  \begin{tikzpicture}[x=1mm,y=1mm]
    \edef\sc@lp{#1}\def\sc@r{#3}%
    \def\sc@onelamp##1##2##3{\edef\sc@t{##1}%
      \ifx\sc@t\sc@lp \fill[##3,opacity=0.30] (##2) circle ({\sc@r*1.38});
        \fill[##3] (##2) circle (\sc@r); \fill[white,opacity=0.35] ($(##2)+({-0.3*\sc@r},{0.35*\sc@r})$) circle ({\sc@r*0.28});
      \else \fill[##3!20!black] (##2) circle (\sc@r);\fi}%
    \if v#2
      \fill[HousingBlack,rounded corners=2.2mm] (0,0) rectangle ({\sc@r*3.2},{\sc@r*9.4});
      \draw[white!40!HousingBlack,line width=0.5pt,rounded corners=2.2mm] (0,0) rectangle ({\sc@r*3.2},{\sc@r*9.4});
      \sc@onelamp{red}{{\sc@r*1.6},{\sc@r*7.7}}{SignalRed}
      \sc@onelamp{amber}{{\sc@r*1.6},{\sc@r*4.7}}{SignalAmber}
      \sc@onelamp{green}{{\sc@r*1.6},{\sc@r*1.7}}{SignalGreen}
    \else
      \fill[HousingBlack,rounded corners=2.2mm] (0,0) rectangle ({\sc@r*9.4},{\sc@r*3.2});
      \sc@onelamp{red}{{\sc@r*1.7},{\sc@r*1.6}}{SignalRed}
      \sc@onelamp{amber}{{\sc@r*4.7},{\sc@r*1.6}}{SignalAmber}
      \sc@onelamp{green}{{\sc@r*7.7},{\sc@r*1.6}}{SignalGreen}
    \fi
  \end{tikzpicture}}

%% ================================================================ CROSSWALK RULE
\newcommand\sc@zebra[2]{% #1 width (dimen), #2 height (dimen)
  \begin{tikzpicture}[x=1pt,y=1pt]
    \pgfmathsetmacro\sc@w{#1}\pgfmathsetmacro\sc@h{#2}
    \fill[Asphalt] (0,0) rectangle (\sc@w,\sc@h);
    \pgfmathtruncatemacro\sc@n{floor((\sc@w-2)/(\sc@h*2.4))}
    \foreach \i in {0,...,\sc@n}{
      \fill[StripeWhite] ({1.5+\i*\sc@h*2.4},{\sc@h*0.2}) rectangle ++({\sc@h*1.2},{\sc@h*0.6});}
  \end{tikzpicture}}
%% the rule closes a section: it is dropped when it would land alone at a page top or does not
%% fit on the current page (DS-19) – an ornament never creates a page of its own.
\newcommand\crosswalkrule[1][2.4mm]{\par
  \ifdim\pagegoal=\maxdimen\else\ifdim\dimexpr\pagegoal-\pagetotal\relax<20pt\else\sc@crosswalkrule{#1}\fi\fi}
\newcommand\sc@crosswalkrule[1]{%
  \nobreak\vspace{6pt}\nobreak\noindent\sc@ltr{\sc@zebra{\linewidth}{#1}}\par\vspace{6pt}}

%% ================================================================ SECTIONS
\newcommand\sc@secchip[1]{\leavevmode\hbox dir TLT{\tikz[baseline=(c.base)]{%
  \node[fill=Asphalt,text=StripeWhite,rounded corners=1.2pt,inner xsep=3.2pt,inner ysep=2.6pt,
     font=\sffamily\bfseries\normalsize] (c) {#1};
  }}\hspace{0.65em}}
\renewcommand\section{\@startsection{section}{1}{\z@}{-3.4ex plus -1ex minus -.2ex}%
  {1.3ex plus .2ex}{\sffamily\bfseries\color{Asphalt}\fontsize{ 16.5}{21}\selectfont}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}{-2.6ex plus -1ex minus -.2ex}%
  {0.9ex plus .2ex}{\sffamily\bfseries\color{Asphalt}\fontsize{12.5}{16}\selectfont}}
\def\sc@secname{section}
%% LaTeX expands \@seccntformat inside \protected@edef: the logic lives in a \protected macro.
\protected\def\sc@seccnt#1{\edef\sc@t{#1}\ifx\sc@t\sc@secname \sc@secchip{\csname the#1\endcsname}%
  \else{\color{\sc@phasecolor}\csname the#1\endcsname}\hspace{0.6em}\fi}
\renewcommand\@seccntformat[1]{\sc@seccnt{#1}}
\setcounter{tocdepth}{2}
\setcounter{secnumdepth}{2}

%% ================================================================ CHAPTER OPENERS (full-bleed band)
\newcommand\sc@mission{}
\newcommand\ChapterMission[1]{\gdef\sc@mission{#1}}       % one-line mission subtitle for the next chapter
\newcommand\sc@chaptericon{}
\newcommand\ChapterIcon[1]{\gdef\sc@chaptericon{#1}}       % pictogram shown in the next chapter band
%% band height (mm) and the skip that brings the text below it
 \def\sc@Hmm{98}\newcommand\sc@bandskip{82mm}

\newcommand\sc@band[3]{% #1 two-digit number (empty = unnumbered), #2 title, #3 mission
  \noindent\sc@ltr{\begin{tikzpicture}[remember picture,overlay,x=1mm,y=1mm]
    \coordinate (P) at (current page.north west);
    \fill[ Asphalt] (P) rectangle ($(P)+(210,-\sc@Hmm)$);
    
      \pgfmathsetseed{17}
      \foreach \k in {1,...,260}{\fill[white,opacity=0.035] ($(P)+({rnd*210},{-rnd*(\sc@Hmm-6)})$) circle (0.3);}
      \fill[AsphaltDeep] ($(P)+(0,-\sc@Hmm)$) rectangle ($(P)+(210,-\sc@Hmm-5)$);
      \foreach \i in {0,...,17}{\fill[StripeWhite] ($(P)+(3+\i*12,-\sc@Hmm-0.9)$) rectangle ++(6,-3.2);}
    
    \ifx\relax#1\relax
      \node[rtl,anchor=south east,inner sep=0pt,text=StripeWhite,font=\sffamily\bfseries\fontsize{30}{36}\selectfont]
        at ($(P)+(188,-\sc@Hmm+16)$) {#2};
      \node[anchor=south west,inner sep=0pt] at ($(P)+(20,-\sc@Hmm+16)$) {\sc@lamps{off}{h}{2.6}};
    \else
      
        \node[anchor=south west,inner sep=0pt] at ($(P)+(14,-\sc@Hmm+16)$) {\sc@lamps{\sc@phase}{v}{3.4}};
        \node[anchor=south west,inner sep=0pt,text=\sc@phasecolor,
          font=\sffamily\bfseries\fontsize{150}{150}\selectfont] at ($(P)+(32,-\sc@Hmm+12)$) {#1};
        \node[anchor=north east,inner sep=0pt,text=StripeWhite!55,font=\fontsize{7}{9}\selectfont]
          at ($(P)+(188,-16)$) {\enlabel{Chapter #1 · \sc@phaseen}};
        \node[rtl,anchor=north east,inner sep=0pt,text=\sc@phasecolor,font=\sffamily\bfseries\fontsize{9.5}{12}\selectfont]
          at ($(P)+(188,-22)$) {פרק~\num{#1}~·~\sc@phasename\ifx\sc@chaptericon\@empty\else~~\picto[\sc@phasecolor]{\sc@chaptericon}\fi};
        \node[rtl,anchor=north east,inner sep=0pt,text=StripeWhite,text width=96mm,align=flush right,
          font=\sffamily\bfseries\fontsize{27}{33}\selectfont] (T) at ($(P)+(188,-31)$) {#2};
        \ifx\relax#3\relax\else
          \fill[\sc@phasecolor] ($(T.south east)+(0,-4.5)$) rectangle ++(-14,-0.9);
          \node[rtl,anchor=north east,inner sep=0pt,text=StripeWhite!78,text width=96mm,align=flush right,
            font=\sffamily\fontsize{11.5}{15}\selectfont] at ($(T.south east)+(0,-8)$) {#3};
        \fi
      
    \fi
  \end{tikzpicture}}\par
  \vspace*{\sc@bandskip}}
\gdef\sc@tabnum{}
\renewcommand\@makechapterhead[1]{%
  \sc@computelamp\xdef\sc@tabnum{\two@digits{\c@chapter}}%
  \sc@band{\two@digits{\c@chapter}}{#1}{\sc@mission}%
  \gdef\sc@mission{}\gdef\sc@chaptericon{}}
\renewcommand\@makeschapterhead[1]{%
  \gdef\sc@phase{none}\sc@band{}{#1}{}}
\renewcommand\chaptermark[1]{\markboth{#1}{}}
%% \inputchapter{N}{file}: chapter N keeps its number, phase, lamp and tab whatever is (not yet) included before it.
%% A chapter file that does not exist yet is skipped (parallel writing).
\newcommand\inputchapter[2]{\IfFileExists{#2.tex}{\clearpage\setcounter{chapter}{\numexpr#1-1\relax}\input{#2}}{}}

%% ================================================================ THUMB TABS (outer = left edge in RTL)
\newcommand\sc@thumbtab{%
  \ifx\sc@phase\sc@ph@red\def\sc@tabtop{112}\else\ifx\sc@phase\sc@ph@amber\def\sc@tabtop{162}\else
    \ifx\sc@phase\sc@ph@green\def\sc@tabtop{212}\else\def\sc@tabtop{}\fi\fi\fi
  \ifx\sc@tabtop\@empty\else
  \sc@ltr{\begin{tikzpicture}[remember picture,overlay,x=1mm,y=1mm]
    \coordinate (P) at (current page.north west);
    
      \fill[\sc@phasecolor,rounded corners=2mm] ($(P)+(-4,-\sc@tabtop)$) rectangle ++(13,-44);
      \node[text=\ifx\sc@phase\sc@ph@amber Asphalt\else StripeWhite\fi,font=\sffamily\bfseries\fontsize{10}{10}\selectfont]
        at ($(P)+(4.3,-\sc@tabtop-22)$) {\sc@tabnum};
    
  \end{tikzpicture}}\fi}

%% ================================================================ HEADER / FOOTER
\newcommand\sc@headtext{%
  \sc@ltr{\begin{tikzpicture}[x=1mm,y=1mm]
    \useasboundingbox (0,0) rectangle (\headwidth,6mm);
    
      \node[anchor=west,inner sep=0pt,text=AsphaltLight,font=\fontsize{6.5}{8}\selectfont] at (0,2.2)
        {\enlabel{Smart Crosswalk · Preparatory Report}};
      \node[rtl,anchor=east,inner sep=0pt,text=Asphalt,font=\sffamily\fontsize{8.5}{10}\selectfont] (h) at (\headwidth,2.2mm) {\leftmark};
      \fill[\sc@phasecolor] ($(h.west)+(-2.6,-1.1)$) rectangle ++(-2.2,2.2);
    
  \end{tikzpicture}}}
\newcommand\sc@foottext{%
  \sc@ltr{\begin{tikzpicture}[x=1mm,y=1mm]
    \useasboundingbox (0,0) rectangle (\headwidth,7mm);
    
      \node[anchor=south west,inner sep=0pt,text=Asphalt,font=\sffamily\bfseries\fontsize{14}{14}\selectfont] (n) at (0,0.6) {\foreignlanguage{hebrew}{\thepage}};
      \begin{scope}\clip ($(n.south east)+(3,0.3)$) rectangle ++(20,3);
        \fill[Asphalt] ($(n.south east)+(3,0.3)$) rectangle ++(20,3);
        \foreach \i in {0,...,6}{\fill[StripeWhite] ($(n.south east)+(4+\i*3,0.9)$) rectangle ++(1.5,1.8);}
      \end{scope}
      \node[rtl,anchor=south east,inner sep=0pt,text=AsphaltLight,font=\sffamily\fontsize{7.5}{9}\selectfont] at (\headwidth,1.2)
        {\sc@footertitle~·~\en{\sc@group}~·~\num{©\,2026}};
    
  \end{tikzpicture}}}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[C]{\sc@thumbtab\sc@headtext}
\fancyfoot[C]{\sc@foottext}
\renewcommand\headrulewidth{0pt}
\renewcommand\footrulewidth{0pt}
\fancypagestyle{plain}{\fancyhf{}\fancyhead[C]{\sc@thumbtab}\fancyfoot[C]{\sc@foottext}}

%% ---------------------------------------------------------------- front / main matter
\newcommand\inputfront[1]{\IfFileExists{#1.tex}{\input{#1}}{}}
%% Hebrew-letter page numbers, independent of the current language (a page shipped during the English abstract printed "1")
\newcommand\sc@hebletter[1]{\ifcase#1\or א\or ב\or ג\or ד\or ה\or ו\or ז\or ח\or ט\or י\or יא\or יב\or יג\or יד\or טו\or טז\else\number#1\fi}
\newcommand\FrontMatter{\clearpage\pagenumbering{roman}%
  \renewcommand\thepage{\sc@hebletter{\value{page}}}}
\newcommand\MainMatter{\clearpage\pagenumbering{arabic}}

%% ---------------------------------------------------------------- table of contents
\renewcommand*\l@chapter[2]{%
  \ifnum\c@tocdepth>\m@ne
    \addpenalty{-\@highpenalty}\vskip 1.1em \@plus\p@
    \setlength\@tempdima{2.4em}%
    \begingroup\parindent\z@\rightskip\@pnumwidth\parfillskip-\@pnumwidth
      \leavevmode\sffamily\bfseries\fontsize{12.5}{16}\selectfont
      \def\numberline##1{\sc@tocchip{##1}\hspace{0.7em}}%
      {\color{Asphalt}#1}\nobreak\hfil\nobreak\hb@xt@\@pnumwidth{\hss\color{Asphalt}#2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}
\newcommand\sc@tocchip[1]{\hbox dir TLT{\tikz[baseline=(c.base)]{%
  \node[fill=\sc@phasecolorof{#1},text=\ifnum#1>3 \ifnum#1<8 Asphalt\else StripeWhite\fi\else StripeWhite\fi,
    rounded corners=1.5pt,inner xsep=3.5pt,inner ysep=2.5pt,font=\sffamily\bfseries\small] (c) {\two@digits{#1}};
  }}}

%% ================================================================ CALLOUT BOXES (PRD §6.3)
%% tcolorbox draws its frame with TikZ in LTR coordinates: each public box builds the box in an LTR
%% paragraph and sets title + content RTL (DS-02).

  \tcbset{sc base/.style={enhanced,breakable,arc=0pt,boxrule=0pt,
    left=4.5mm,right=5.5mm,top=1.2mm,bottom=2.6mm,toptitle=2.4mm,bottomtitle=0.2mm,
    fonttitle=\sffamily\bfseries\fontsize{9.5}{12}\selectfont,
    before skip=11pt,after skip=11pt,parbox=false,
    before upper={\pardir TRT\textdir TRT},before title={\pardir TRT\textdir TRT}},
    sc box/.style={sc base,colback=StripeWhite!70,colbacktitle=StripeWhite!70,coltitle=#1,
      borderline east={2.6pt}{0pt}{#1}}}

\newcommand\sc@boxtitle[2]{\picto[#1]{#2}\hspace{0.5em}}

  \newtcolorbox{sc@findingbox}[1]{sc box=SignalGreen,title={\sc@boxtitle{SignalGreen}{signal}#1}}
  \newtcolorbox{sc@cautionbox}[1]{sc box=SignalAmber!85!black,title={\sc@boxtitle{SignalAmber!85!black}{warning}#1}}
  \newtcolorbox{sc@trapbox}[1]{sc box=SignalRed,title={\sc@boxtitle{SignalRed}{pedestrian}#1}}
  \newtcolorbox{sc@definitionbox}[1]{sc box=Asphalt,title={\sc@boxtitle{Asphalt}{info}#1}}
  \newtcolorbox{sc@projectbox}[1]{sc box=AsphaltLight,title={\sc@boxtitle{AsphaltLight}{sensor}#1}}

%% scene box: chapter-opening street scene, max 4 lines (PRD §12)

  \newtcolorbox{sc@scenebox}{enhanced,colback=AsphaltDeep,colupper=StripeWhite,boxrule=0pt,arc=1.6mm,
    left=5mm,right=18mm,top=5mm,bottom=5mm,fontupper=\sffamily\fontsize{10.5}{15}\selectfont,parbox=false,
    before skip=2pt,after skip=14pt,before upper={\pardir TRT\textdir TRT},
    overlay={
      \begin{scope}\clip ($(frame.south west)+(2.5mm,0)$) rectangle ($(frame.north east)+(-2.5mm,0)$);
        \foreach \i in {0,...,60}{%
          \fill[StripeWhite,opacity=0.8] ($(frame.north west)+(3mm+\i*4.4mm,-1.2mm)$) rectangle ++(2.2mm,-1mm);
          \fill[StripeWhite,opacity=0.8] ($(frame.south west)+(3mm+\i*4.4mm,1.2mm)$) rectangle ++(2.2mm,1mm);}
      \end{scope}
      \node[anchor=east,fill=HousingBlack,rounded corners=1.2mm,inner sep=1.6mm] at ($(frame.east)+(-4mm,0)$)
        {\fontsize{16}{16}\selectfont\picto[SignalRed]{pedestrian}};}}

\newcommand\sc@ltrpar{\par\pardir TLT\textdir TLT}
\newenvironment{findingbox}[1][ממצא מרכזי]{\sc@ltrpar\begin{sc@findingbox}{#1}}{\end{sc@findingbox}\par}
\newenvironment{cautionbox}[1][שימו לב: סוגיה בנתונים]{\sc@ltrpar\begin{sc@cautionbox}{#1}}{\end{sc@cautionbox}\par}
\newenvironment{trapbox}[1][מלכודת]{\sc@ltrpar\begin{sc@trapbox}{#1}}{\end{sc@trapbox}\par}
\newenvironment{definitionbox}[1][הגדרה]{\sc@ltrpar\begin{sc@definitionbox}{#1}}{\end{sc@definitionbox}\par}
\newenvironment{projectbox}[1][בפרויקט הנוכחי]{\sc@ltrpar\begin{sc@projectbox}{#1}}{\end{sc@projectbox}\par}
\newenvironment{scenebox}{\sc@ltrpar\begin{sc@scenebox}}%
  {\end{sc@scenebox}\par}% scene length: character heuristic in qa.py (\prevgraf is not set under babel's Lua line breaking)

%% ================================================================ PULL QUOTE

  \newtcolorbox{sc@pullquote}{enhanced,blank,parbox=false,left=0mm,right=9mm,top=1mm,bottom=1mm,
    before skip=12pt,after skip=12pt,borderline east={2.4pt}{0pt}{SignalRed},
    fontupper=\sffamily\bfseries\color{Asphalt}\fontsize{15.5}{21}\selectfont,
    before upper={\pardir TRT\textdir TRT}}

\newcommand\sc@quoteby{}
\newenvironment{pullquote}[1][]{\def\sc@quoteby{#1}\sc@ltrpar\begin{sc@pullquote}}%
  {\ifx\sc@quoteby\@empty\else\par\vspace{3pt}{\normalfont\sffamily\fontsize{8.5}{11}\selectfont\color{AsphaltLight}— \sc@quoteby}\fi
   \end{sc@pullquote}\par}

%% ================================================================ MARGIN NOTES (left / outer margin)
\reversemarginpar
\newcommand\sidenote[1]{\marginpar{\pardir TRT\textdir TRT\raggedright\hyphenpenalty=10000\sffamily\fontsize{7.8}{10.5}\selectfont\color{AsphaltLight}%
  \picto[SignalRed]{info}\hspace{0.3em}#1}}

%% ================================================================ KEY-FIGURE (STAT) TILES
%% \begin{statrow}[n] \stattile[colour]{number}{label} ... \end{statrow}
\newlength\sc@tilew
\newenvironment{statrow}[1][3]{\par\vspace{8pt}\noindent
  \setlength\sc@tilew{\dimexpr(\linewidth-4mm*(#1-1))/#1\relax}\parfillskip=0pt\ignorespaces}{\unskip\unskip\par\vspace{8pt}}
\newcommand\stattile[3][SignalAmber]{%
  \sc@ltr{\begin{tikzpicture}[x=1mm,y=1mm]
    \pgfmathsetmacro\sc@tw{\sc@tilew/1mm}
    \useasboundingbox (0,0) rectangle (\sc@tw,31);
    
      \fill[Asphalt,rounded corners=1.6mm] (0,0) rectangle (\sc@tw,31);
      \fill[#1] (\sc@tw-4,31) rectangle ++(-12,-1.4);
      \node[anchor=north east,inner sep=0pt,text=#1,font=\sffamily\bfseries\fontsize{27}{27}\selectfont] at (\sc@tw-4,25.5) {#2};
      \node[rtl,anchor=north east,inner sep=0pt,text=StripeWhite!85,text width={(\sc@tw-8)*1mm},align=flush right,
        font=\sffamily\fontsize{8.5}{11}\selectfont] at (\sc@tw-4,12) {#3};
    
  \end{tikzpicture}}\hspace{4mm plus 2pt minus 1pt}\ignorespaces}

%% ================================================================ AUTHOR PHOTO (PRD §5: own photographs only)
%% \authorphoto[height]{file}{caption}{label} – our own photograph, credited "צילום: המחברים".
%% If the file does not exist yet, a placeholder frame is drawn.
\newcommand\photocredit{צילום: המחברים}
\newcommand\authorphoto[4][62mm]{%
  \begin{figure}[ht]\centering
    \sc@ltrcenter{\IfFileExists{#2}{%
      \tikz{\node[inner sep=0pt,draw=Asphalt,line width=0.6pt]
        {\includegraphics[width=\linewidth,height=#1,keepaspectratio]{#2}};}%
      }%
     {\begin{tikzpicture}[x=1mm,y=1mm]
        \pgfmathsetmacro\sc@ph{#1/1mm}\pgfmathsetmacro\sc@pw{\linewidth/1mm}
        \fill[ Concrete!55] (0,0) rectangle (\sc@pw,\sc@ph);
        \draw[AsphaltLight,line width=0.5pt,dash pattern=on 3pt off 2pt] (1.5,1.5) rectangle (\sc@pw-1.5,\sc@ph-1.5);
        \node at (\sc@pw/2,\sc@ph/2+7) {\fontsize{30}{30}\selectfont\picto[AsphaltLight]{camera}};
        \node[rtl,text=AsphaltLight,font=\sffamily\fontsize{9.5}{12}\selectfont] at (\sc@pw/2,\sc@ph/2-6) {מקום לצילום של המחברים};
        \node[text=AsphaltLight,font=\ttfamily\fontsize{7.5}{9}\selectfont] at (\sc@pw/2,\sc@ph/2-11) {\detokenize{#2}};
      \end{tikzpicture}}}%
    \caption{#3. \photocredit}\label{#4}
  \end{figure}}

%% ---------------------------------------------------------------- figure inclusion that tolerates files not yet produced
%% \inputfigure{figures/tikz/name}      – TikZ file in an LTR block
%% \includefigure[width]{figures/name.pdf} – PDF figure
%% Until the file exists, a labelled placeholder frame is shown (parallel rounds).
\newcommand\sc@figpending[1]{\sc@ltrcenter{\begin{tikzpicture}[x=1mm,y=1mm]
  \draw[AsphaltLight,dash pattern=on 3pt off 2pt] (0,0) rectangle (120,30);
  \node[rtl,text=AsphaltLight,font=\sffamily\small] at (60,18) {איור בהכנה};
  \node[text=AsphaltLight,font=\ttfamily\scriptsize] at (60,10) {\detokenize{#1}};\end{tikzpicture}}}
\newcommand\inputfigure[1]{\IfFileExists{#1.tex}{\begin{ltrblock}\input{#1}\end{ltrblock}}{\sc@figpending{#1.tex}}}
\newcommand\includefigure[2][\linewidth]{\IfFileExists{#2}{\sc@ltrcenter{\includegraphics[width=#1]{#2}}}{\sc@figpending{#2}}}

%% ---------------------------------------------------------------- captions
\DeclareCaptionFont{scasphalt}{\color{Asphalt}}
\DeclareCaptionFont{scgrey}{\color{AsphaltLight}}
\captionsetup{font={small,sf,scgrey},labelfont={bf,scasphalt},labelsep=colon,skip=7pt}
\captionsetup[table]{position=top}

%% ================================================================ TABLES
%% Column 1 is on the right (babel layout=tabular). Header row: \headrow \thead{..} & \thead{..} \\
\renewcommand\arraystretch{1.32}

  \setlength\heavyrulewidth{0.9pt}\setlength\lightrulewidth{0.4pt}\arrayrulecolor{Asphalt}
  \newcommand\thead[1]{\leavevmode{\sffamily\bfseries\color{Asphalt}#1}}% \leavevmode: no line drop in p/X columns
  \newcommand\headrow{}
  \AtBeginEnvironment{tabular}{\small}

\AtBeginEnvironment{tabularx}{\small}
\renewcommand\tabularxcolumn[1]{>{\raggedright\arraybackslash}p{#1}}% narrow X columns ragged (RTL start side), no word gaps

%% ---------------------------------------------------------------- floats (DS-16)
\setlength\@fptop{0pt}\setlength\@fpsep{14pt}\setlength\@fpbot{0pt plus 1fil}% skip registers in LaTeX 2025+
\renewcommand\topfraction{0.85}\renewcommand\textfraction{0.12}\renewcommand\floatpagefraction{0.75}

%% ---------------------------------------------------------------- equations
\numberwithin{equation}{chapter}

%% ================================================================ COVER (full bleed)
%% Aerial (top-down) crosswalk, drawn in local mm coordinates: width 210, height #1.
\newcommand\sc@ped[5]{% x, y, jacket colour, rotation, scale – top-down pedestrian with shadow
  \colorlet{sc@jacket}{#3}%
  \begin{scope}[shift={(#1,#2)},rotate=#4,scale=#5]
    \fill[black,opacity=0.30] (1.5,-1.5) ellipse (3.2 and 1.75);
    \fill[black,opacity=0.30] (1.5,-1.3) circle (1.35);
    \fill[sc@jacket] (0,0) ellipse (3.2 and 1.7);
    \fill[sc@jacket!70!black] (0,-0.55) ellipse (2.4 and 0.8);
    \fill[black!80] (0,0.15) circle (1.3);
  \end{scope}}
\newcommand\sc@signalhead[3]{% x, y, scale – countdown pedestrian head on a pole (stylised, with shadow)
  \begin{scope}[shift={(#1,#2)},scale=#3]
    \fill[black,opacity=0.28] (1.6,-1.6) circle (1.6);
    \fill[black!65] (0,0) circle (1.5);
    \fill[black,opacity=0.25,rounded corners=1.4] (-4.4,1.4) rectangle (7.6,19.4);
    \fill[HousingBlack,rounded corners=1.4] (-6,3) rectangle (6,21);
    \draw[white!30!HousingBlack,line width=0.4pt,rounded corners=1.4] (-6,3) rectangle (6,21);
    \fill[black] (-4.6,12.6) rectangle (4.6,19.6);
    % clearance interval: green walking figure + countdown (the project counts down ONLY here – PRD §1, Step 15)
    \node[inner sep=0] at (0,16.1) {\fontsize{17}{17}\selectfont\picto[SignalGreen]{walker}};
    \fill[black] (-4.6,4.4) rectangle (4.6,11.4);
    \node[text=SignalAmber,font=\sffamily\bfseries\fontsize{15}{15}\selectfont,inner sep=0pt] at (0,7.9) {12};
  \end{scope}}
\newcommand\sc@aerial[1]{%
  \pgfmathsetmacro\H{#1}\pgfmathsetmacro\mid{(32+\H-40)/2}
  % road with texture
  \fill[Road] (0,32) rectangle (210,\H-40);
  \pgfmathsetseed{2026}
  \foreach \k in {1,...,520}{\fill[white,opacity=0.045] ({rnd*210},{32+rnd*(\H-72)}) circle (0.28);}
  % sidewalks, paving joints, curbs
  \fill[Concrete] (0,\H-38) rectangle (210,\H);  \fill[Concrete] (0,0) rectangle (210,30);
  \foreach \x in {0,14,...,210}{\draw[ConcreteJoint,line width=0.35pt] (\x,\H-38)--(\x,\H) (\x,0)--(\x,30);}
  \foreach \y in {12,24}{\draw[ConcreteJoint,line width=0.35pt] (0,\H-38+\y)--(210,\H-38+\y) (0,\y-6)--(210,\y-6);}
  \fill[Curb] (0,\H-40) rectangle (210,\H-38); \fill[Curb] (0,30) rectangle (210,32);
  \fill[black,opacity=0.18] (0,\H-41.2) rectangle (210,\H-40);
  % lane markings and stop lines
  \foreach \x in {2,16,...,64}{\fill[StripeWhite,opacity=0.75] (\x,\mid-0.6) rectangle ++(8,1.2);}
  \foreach \x in {146,160,...,206}{\fill[StripeWhite,opacity=0.75] (\x,\mid-0.6) rectangle ++(8,1.2);}
  \fill[StripeWhite,opacity=0.9] (70,32) rectangle (71.8,\mid-1.5);
  \fill[StripeWhite,opacity=0.9] (138.2,\mid+1.5) rectangle (140,\H-40);
  % zebra crossing
  \pgfmathtruncatemacro\nz{floor((\H-40-32-6)/9)}
  \foreach \i in {0,...,\nz}{\fill[StripeWhite] (80,{35+\i*9}) rectangle (130,{39.8+\i*9});}
  % stopped car (lower lane, before the stop line)
  \begin{scope}[shift={(48,{(32+\mid)/2})}]
    \fill[black,opacity=0.28,rounded corners=3] (-11.5,-5.6) rectangle (13.5,7.6);
    \fill[AsphaltLight!80!white,rounded corners=3] (-13,-7) rectangle (12,6.4);
    \fill[HousingBlack,rounded corners=1.5] (3,-5.6) rectangle (7.6,5.0);
    \fill[HousingBlack,rounded corners=1.5] (-10.5,-5) rectangle (-7.6,4.4);
    \fill[SignalRed!80!black] (-13,-6) rectangle (-12.2,-3.8); \fill[SignalRed!80!black] (-13,3.2) rectangle (-12.2,5.4);
  \end{scope}
  % curb-side sensing zone (the smart crossing)
  \fill[SignalAmber,opacity=0.16] (140,\H-35) -- ++(186:56) arc[start angle=186,end angle=154,radius=56] -- cycle;
  \draw[SignalAmber,line width=0.6pt,dash pattern=on 2.4pt off 1.6pt,opacity=0.9]
    (140,\H-35) -- ++(186:56) arc[start angle=186,end angle=154,radius=56] -- cycle;
  \fill[HousingBlack] (140,\H-35) circle (1.7); \fill[SignalAmber] (140,\H-35) circle (0.7);
  % the waiting group (far curb) and the lone pedestrian (near curb, stepping off)
  \sc@ped{91}{\H-27}{AsphaltLight}{0}{1.45}
  \sc@ped{102}{\H-23}{Asphalt!80}{8}{1.5}
  \sc@ped{112}{\H-29}{SignalGreen!75!black}{-6}{1.4}
  \sc@ped{122}{\H-22}{AsphaltLight!70!black}{4}{1.45}
  \sc@ped{130}{\H-30}{SignalAmber!85!black}{-10}{1.4}
  \sc@ped{98}{27}{SignalRed}{12}{1.5}
  % countdown signal heads (one per curb)
  \sc@signalhead{146}{\H-22}{0.95}
  \sc@signalhead{66}{9}{0.95}}
\newcommand\makecover{%
  \begin{titlepage}\thispagestyle{empty}
  \noindent\sc@ltr{\begin{tikzpicture}[remember picture,overlay,x=1mm,y=1mm]
    \begin{scope}[shift={(current page.south west)}]
    
      %% ---------------- A: bold editorial
      \begin{scope}[shift={(0,112)}]\sc@aerial{185}\end{scope}
      \fill[AsphaltDeep] (0,0) rectangle (210,112);
      \fill[SignalRed] (0,112) rectangle (210,113.4);
      \node[anchor=north west,inner sep=0pt,text=StripeWhite!50,font=\fontsize{7}{9}\selectfont] at (20,102)
        {\enlabel{Preparatory report · Group \sc@group{} · 2026}};
      \node[rtl,anchor=north east,fill=white,draw=SignalRed,line width=1.5pt,rounded corners=1.6mm,
        inner xsep=4.5mm,inner ysep=2.2mm,text=Asphalt,font=\sffamily\bfseries\fontsize{11}{13}\selectfont] (plate) at (190,104)
        {דוח מכין};
      \draw[white,line width=0.6pt,rounded corners=2.4mm] ($(plate.south west)+(-1,-1)$) rectangle ($(plate.north east)+(1,1)$);
      \node[rtl,anchor=north east,inner sep=0pt,text=StripeWhite,font=\sffamily\bfseries\fontsize{50}{56}\selectfont] at (190,88)
        {\sc@title};
      \node[rtl,anchor=north east,inner sep=0pt,text=StripeWhite!82,text width=170mm,align=flush right,
        font=\sffamily\fontsize{15}{20}\selectfont] at (190,62) {\sc@subtitle};
      \node[anchor=north east,inner sep=0pt,text=SignalAmber,font=\fontsize{11}{14}\selectfont] at (190,49)
        {\en{\itshape\sc@entitle}};
      \begin{scope}\clip (20,35) rectangle (190,37.6);
        \fill[Asphalt] (20,35) rectangle (190,37.6);
        \foreach \i in {0,...,40}{\fill[StripeWhite] (21+\i*4.4,35.5) rectangle ++(2.2,1.6);}\end{scope}
      \foreach \x/\lab/\val in {190/מוסד/\sc@institution, 125/מרצה/\sc@lecturer, 62/מחברים/\sc@authors}{
        \node[rtl,anchor=north east,inner sep=0pt,text=SignalAmber,font=\sffamily\bfseries\fontsize{7.5}{9}\selectfont] at (\x,29) {\lab};
        \node[rtl,anchor=north east,inner sep=0pt,text=StripeWhite!85,text width=58mm,align=flush right,
          font=\sffamily\fontsize{9}{12}\selectfont] at (\x,24) {\val};}
      \node[rtl,anchor=north east,inner sep=0pt,text=StripeWhite!85,text width=58mm,align=flush right,
          font=\sffamily\fontsize{9}{12}\selectfont] at (62,19) {קבוצה: \en{\sc@group}};
      \node[rtl,anchor=north east,inner sep=0pt,text=StripeWhite!60,text width=58mm,align=flush right,
          font=\sffamily\fontsize{8}{11}\selectfont] at (190,10.5) {\sc@course};
      \node[rtl,anchor=north east,inner sep=0pt,text=StripeWhite!60,font=\sffamily\fontsize{8}{11}\selectfont] at (62,10.5) {\sc@docdate};
    
    \end{scope}
  \end{tikzpicture}}
  \end{titlepage}}

%% ================================================================ BIBLIOGRAPHY
%% Citations are one LTR unit set in ENGLISH: otherwise the brackets mirror in RTL text (DS-04).
\AtBeginDocument{%
  \let\sc@origcite\cite
  \DeclareRobustCommand\cite{\@ifnextchar[\sc@citeopt\sc@citeplain}}
\def\sc@citebox#1{\leavevmode\hbox dir TLT{\foreignlanguage{english}{#1}}}
\def\sc@citeplain#1{\sc@citebox{\sc@origcite{#1}}}
\def\sc@citeopt[#1]{\@ifnextchar[{\sc@citetwo[#1]}{\sc@citeone[#1]}}
\def\sc@citeone[#1]#2{\sc@citebox{\sc@origcite[#1]{#2}}}
\def\sc@citetwo[#1][#2]#3{\sc@citebox{\sc@origcite[#1][#2]{#3}}}
%% The standard hanging-indent list is mirrored in this RTL document (the list was shifted 8 mm into the margin,
%% round-2 red team R2-04). Bibliography items: no left margin, label inside a fixed first-line indent.
\defbibenvironment{bibliography}
  {\list{\printtext[labelnumberwidth]{\printfield{labelprefix}\printfield{labelnumber}}}
     {\setlength{\leftmargin}{0pt}\setlength{\labelwidth}{2.2em}\setlength{\labelsep}{0.6em}%
      \setlength{\itemindent}{2.8em}\setlength{\itemsep}{\bibitemsep}\setlength{\parsep}{\bibparsep}}%
   \renewcommand*{\makelabel}[1]{##1\hss}}
  {\endlist}
  {\item}
\newcommand\printreferences{%
  \chapter*{מקורות}\addcontentsline{toc}{chapter}{מקורות}\markboth{מקורות}{}%
  \begin{otherlanguage}{english}\setquotestyle{english}\raggedright\printbibliography[heading=none]\end{otherlanguage}}

\endinput
