% Diego Alvarez S.
% LateX class for theses at the University of Magallanes
% Version 0.1.0
% 2023
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{umagthesis}[2023/07/25 UMAG Thesis Format]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}

\ProcessOptions\relax
\LoadClass[letterpaper,11pt,final]{memoir}

% packages
\RequirePackage{fontspec}
\RequirePackage{graphicx}
\RequirePackage{fancyhdr}
\RequirePackage[dvipsnames]{xcolor}

% margins
\RequirePackage[
	top        = 2cm,
	bottom     = 2.5cm,
	outer      = 2cm,
	inner      = 2.5cm,
	headsep    = 1cm,
	headheight = 16pt
]{geometry}

% linking and pdf options
\RequirePackage[
	final,
	hidelinks,
	pdfusetitle
]{hyperref}