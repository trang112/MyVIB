clear all 
set more off

use "C:\Users\Trang Bui\Desktop\TrangBui\dataraw.dta", clear
cd "C:\Users\Trang Bui\Desktop\TrangBui"
log using result.log, replace 

**rename the variables**
rename q02 aFP
rename q16 SIN
rename q13 bAT
rename q19 bCOA
rename q15sq bCSSB
rename q05_3 bRisk
rename q17 bEE
rename q03sq2 bFPConfidence
rename q04sq2 bFPconfidence
rename q14 selfeffort
rename f01 cgender
rename f02 cage
rename f04 ceducation
rename f05 cincome
rename f06 cmaritalstatus
rename f09 cHouseincome
rename f10 cHomeowner
rename f11 cFinancialassets
rename f06sq1 cchildren 
rename f03 job 
rename q1501 lifeinsurance 
rename q1503 savedeposit 
rename q1504 securities 

**label variables**
label var SIN "saving intention"
label var aFP "Financial planning"
label var bAT "Anxiety toward old age"
label var bCOA "Confidence in having enough money in old age"
label var bCSSB "Confidence in social benefits"
label var bEE "expected expenses"
label var bFPConfidence "Financial preparation confidence"
label var bFPconfidence "Financial preparation confidence"
label var bRisk "Risk attitude"
label var job "respondents job"


*descriptive statistic for life planning
tab aFP
replace q02sq1=. if q02sq1==-8888
replace q02sq1=. if q02sq1==-9999
gen cyear=.
replace cyear=1 if q02sq1<=5
replace cyear=2 if q02sq1>=6 & q02sq1<=10
replace cyear=3 if q02sq1>=11 & q02sq1<=15
replace cyear=4 if q02sq1>=16 & q02sq1<=20
replace cyear=5 if q02sq1>20
tab cyear

** for expected expense 
tab bEE
replace bEE=. if bEE==-9999
gen Eexpense= bEE
replace Eexpense=1 if bEE<15
replace Eexpense=2 if bEE>=15 & bEE<20
replace Eexpense=3 if bEE>=20 & bEE<25
replace Eexpense=4 if bEE>=25 & bEE<30
replace Eexpense=5 if bEE>=30 & bEE<40
replace Eexpense=6 if bEE>=40
 tab Eexpense
***transforming missing values to"."
*recode 
recode cincome (11=.)
recode cmaritalstatus (4=.)
recode ceducation (7=.)
recode cchildren (3=.)
recode cHouseincome (8=.)
recode cHomeowner (6=.)
recode cFinancialassets(8=.)

**Cleansing database***
drop if SIN==5
drop if aFP==3
drop if bAT==5
drop if bCSSB==5
drop if bEE==-9999
drop if bFPconfidence==5
drop if bFPconfidence==-8888
drop if bFPConfidence==5
drop if bFPConfidence==-8888
drop if bRisk==5
drop if cchildren==-8888
drop if cHouseincome==-8888


** Financial literacy computation**
*Computing correct answers for financial literacy question
g f12_1C=.
replace f12_1C=0 if f12_1==1
replace f12_1C=0 if f12_1==3
replace f12_1C=1 if f12_1==2

g f12_2C=.
replace f12_2C=0 if f12_2==1
replace f12_2C=0 if f12_2==3
replace f12_2C=1 if f12_2==2

g f12_3C=.
replace f12_3C=0 if f12_3==2
replace f12_3C=0 if f12_3==3
replace f12_3C=1 if f12_3==1

g f12_4C=.
replace f12_4C=0 if f12_4==1
replace f12_4C=0 if f12_4==3
replace f12_4C=1 if f12_4==2
g f12_5C=.
replace f12_5C=0 if f12_5==2
replace f12_5C=0 if f12_5==3
replace f12_5C=1 if f12_5==1
g f12_6C=.
replace f12_6C=0 if f12_6==1
replace f12_6C=0 if f12_6==3
replace f12_6C=1 if f12_6==2
g aFL= f12_1C+f12_2C+f12_3C+f12_4C+f12_5C+f12_6C
tab aFL


*Computing incorrect answer for the financial literacy question
g f12_1I=.
replace f12_1I=1 if f12_1==1
replace f12_1I=0 if f12_1==3
replace f12_1I=0 if f12_1==2
g f12_2I=.
replace f12_2I=1 if f12_2==1
replace f12_2I=0 if f12_2==3
replace f12_2I=0 if f12_2==2

g f12_3I=.
replace f12_3I=1 if f12_3==2
replace f12_3I=0 if f12_3==3
replace f12_3I=0 if f12_3==1
g f12_4I=.
replace f12_4I=1 if f12_4==1
replace f12_4I=0 if f12_4==3
replace f12_4I=0 if f12_4==2
g f12_5I=.
replace f12_5I=1 if f12_5==2
replace f12_5I=0 if f12_5==3
replace f12_5I=0 if f12_5==1
g f12_6I=.
replace f12_6I=1 if f12_6==1
replace f12_6I=0 if f12_6==3
replace f12_6I=0 if f12_6==2

g FI= f12_1I+ f12_2I+f12_3I+f12_4I+ f12_5I+f12_6I
tab FI

*Computing "DONT KNOW" answer for the financial literacy question
g f12_1D=.
replace f12_1D=0 if f12_1==1
replace f12_1D=1 if f12_1==3
replace f12_1D=0 if f12_1==2

g f12_2D=.
replace f12_2D=0 if f12_2==2
replace f12_2D=1 if f12_2==3
replace f12_2D=0 if f12_2==1

g f12_3D=.
replace f12_3D=0 if f12_3==2
replace f12_3D=1 if f12_3==3
replace f12_3D=0 if f12_3==1

g f12_4D=.
replace f12_4D=0 if f12_4==1
replace f12_4D=1 if f12_4==3
replace f12_4D=0 if f12_4==2
g f12_5D=.
replace f12_5D=0 if f12_5==2
replace f12_5D=1 if f12_5==3
replace f12_5D=0 if f12_5==1
g f12_6D=.
replace f12_6D=0 if f12_6==1
replace f12_6D=1 if f12_6==3
replace f12_6D=0 if f12_6==2

g FD= f12_1D+ f12_2D+f12_3D+f12_4D+ f12_5D+f12_6D
tab FD
 
 **FACTOR ANALYSIS FOR FINANCIAL LITERACY 
global mlist f12_1C f12_1D f12_2C f12_2D f12_3C f12_3D f12_4C f12_4D f12_5C f12_5D f12_6C f12_6D
sum $mlist
corr $mlist
tetrachoric f12_1C f12_1D f12_2C f12_2D f12_3C f12_3D f12_4C f12_4D f12_5C f12_5D f12_6C f12_6D
tetrachoric f12_1C f12_1D f12_2C f12_2D f12_3C f12_3D f12_4C f12_4D f12_5C f12_5D f12_6C f12_6D, notable posdef 

*Factor analysis 
matrix C = r(corr)
matrix symeigen eigenvectors eigenvalues = C
matrix list eigenvalues
factormat C, n(1915)  ipf factor(2) mineigen(1)

*scree plot of the eigen value 
screeplot 
screeplot, yline(1) 

*Factor rotations 
rotate, promax
sortl

* scatter plots of the loadings and score variables 
loadingplot 
scoreplot
*Test for the appropriateness of the model 
factortest f12_1C f12_1D f12_2C f12_2D f12_3C f12_3D f12_4C f12_4D f12_5C f12_5D f12_6C f12_6D
*Validity of the variables and factors 
alpha f12_1C f12_1D f12_2C f12_2D f12_3C f12_3D f12_4C f12_4D f12_5C f12_5D f12_6C f12_6D
alpha f12_4C f12_4D f12_5C f12_5D f12_6C f12_6D
alpha f12_1C f12_1D f12_2C f12_2D f12_3C f12_3D

*scores of the components 
predict fd1 fd2
gen FL1=-fd1
gen FL2=-fd2

*CREATING QUANTILES FOR FINANCIAL LITERACY 
sort FL1
sort FL2
xtile FL1_4=FL1, nq(4)
xtile FL2_4=FL2, nq(4)


xtile FL1_2=FL1, nq(2)
xtile FL2_2=FL2, nq(2)

**Change variables related to confidence in descending order***
g bcon1=.
replace bcon1=1 if bFPConfidence==4
replace bcon1=2 if bFPConfidence==3
replace bcon1=3 if bFPConfidence==2
replace bcon1=4 if bFPConfidence==1
tab bcon1

g bcon2=.
replace bcon2=1 if bFPconfidence==4
replace bcon2=2 if bFPconfidence==3
replace bcon2=3 if bFPconfidence==2
replace bcon2=4 if bFPconfidence==1
tab bcon2

g bCSSB1=.
replace bCSSB1=1 if bCSSB==4
replace bCSSB1=2 if bCSSB==3
replace bCSSB1=3 if bCSSB==2
replace bCSSB1=4 if bCSSB==1

g bCOA1=.
replace bCOA1=1 if bCOA==4
replace bCOA1=2 if bCOA==3
replace bCOA1=3 if bCOA==2
replace bCOA1=4 if bCOA==1

**Define financial confidence
g bconf= bAT+bcon1+bcon2+bCSSB1
tab bconf

g bconf1=.
replace bconf1=1 if bconf>=4 & bconf<=7
replace bconf1=2 if bconf>=8 & bconf<=11
replace bconf1=3 if bconf>=12 & bconf<=16

global nlist bAT bCOA1 bCSSB1 bcon1 bcon2
sum $nlist
corr $nlist

*Factor analysis
polychoric bAT bCSSB1 bcon1 bcon2
display r(sum_w)
global N = r(sum_w)
matrix r = r(R)

factormat r, n(1908) factors(1) mineigen(1)
 
*scree plot of the eigen value 
screeplot 
screeplot, yline(1) 

*Factor rotations 
rotate, promax
sortl

*Test for the appropriateness of the model 
factortest $nlist
*Validity of the variables and factors 
alpha $nlist

*scores of the components 
predict FC

*CREATING QUANTILE FOR FINANCIAL CONFIDENCE 
sort FC
xtile FC_4=FC, nq(4) 
xtile FC_2=FC, nq(2)

**Replace the order of financial planning
replace aFP=0 if aFP==2

**Replace the order of saving intention 
g SIN1=.
replace SIN1=1 if SIN==1
replace SIN1=1 if SIN==2
replace SIN1=0 if SIN==3
replace SIN1=0 if SIN==4

** Age dummy 
gen Cage= cage 
replace Cage=1 if cage<=40
replace Cage=2 if cage>40 & cage<=60
replace Cage=3 if cage>60
tabulate Cage, gen(age_)

** education dummy 
gen Cedu = ceducation 
replace Cedu=0 if ceducation==1
replace Cedu=0 if ceducation==2
replace Cedu=1 if ceducation==3
replace Cedu=1 if ceducation==4
replace Cedu=1 if ceducation==5
replace Cedu=1 if ceducation==6
tabulate Cedu, gen(edu_)

** occupation dummy 
gen cselfe=.
replace cselfe= 1 if job==2 
replace cselfe= 1 if job==3 
replace cselfe= 1 if job==4
replace cselfe= 0 if cselfe!=1  

gen goveremployee=.
replace goveremployee=1 if job==6
replace goveremployee=0 if job!=6

gen studentunem=.
replace studentunem=1 if job==15
replace studentunem=0 if job!=15

gen partime=.
replace partime=1 if job==13
replace partime=0 if job!=13

gen jobb=. 
replace jobb=1 if job==2
replace jobb=1 if job==3 
replace jobb=1 if job==6
replace jobb=1 if job==7
replace jobb=1 if job==10
replace jobb=1 if job==11
replace jobb=0 if jobb!=1




**Risk preference 
gen Risk = bRisk 
replace Risk=1 if bRisk==1
replace Risk=1 if bRisk==2
replace Risk=0 if bRisk==3
replace Risk=0 if bRisk==4
 
** gender dummy 
gen cfemale=.
replace cfemale=1 if cgender==2
replace cfemale=0 if cgender==1

**House hold income 
gen Houseinc=.
replace Houseinc=150 if cHouseincome==1
replace Houseinc=400 if cHouseincome==2
replace Houseinc=600 if cHouseincome==3
replace Houseinc=850 if cHouseincome==4
replace Houseinc=1250 if cHouseincome==5
replace Houseinc=1750 if cHouseincome==6
replace Houseinc=2000 if cHouseincome==7
replace Houseinc=. if cHouseincome==8

**Income 
gen inc=.
replace inc=0 if cHouseincome==1
replace inc=50 if cHouseincome==2
replace inc=150 if cHouseincome==3
replace inc=250 if cHouseincome==4
replace inc=400 if cHouseincome==5
replace inc=650 if cHouseincome==6
replace inc=850 if cHouseincome==7
replace inc= 1250 if cHouseincome==8
replace inc= 1750 if cHouseincome==9
replace inc= 2500 if cHouseincome==10

**Financial assets
gen FINA=. 
replace FINA=50 if cFinancialassets==1
replace FINA=200 if cFinancialassets==2
replace FINA=400 if cFinancialassets==3
replace FINA=750 if cFinancialassets==4
replace FINA=1500 if cFinancialassets==5
replace FINA=2500 if cFinancialassets==6
replace FINA=3000 if cFinancialassets==7
replace FINA=. if cFinancialassets==8

*** Descriptive statistics***
tabulate Cage FL1_4, row
tabulate Cedu FL1_4, row
tabulate cfemale FL1_4, row

tabulate Cage FL2_4, row
tabulate Cedu FL2_4, row
tabulate cfemale FL2_4, row

*cross tabulation and chi-square test 
tab2 cfemale FL1_2, chi2 row
tab2 cfemale FL2_2, chi2 row
tab2 cfemale SIN1, chi2 row
tab2 cfemale FC_2, chi2 row
tab2 cfemale bconf1, chi2 row
tab2 cfemale aFP, chi2 row

** Interaction term 
gen FL1cfe= FL1*cfemale 
gen FL2cfe= FL2*cfemale

**Global variables 
global x2_list FL1 cfemale FL1cfe age_2 age_3 edu_2 jobb Houseinc Risk
global ylist aFP
global zlist SIN1
global wlist bconf1
global tlist FC_4

describe  $x2_list $ylist $zlist $wlist
summarize $x2_list $ylist $zlist $wlist

***Logit orderred regression****
**For financial planning**
logit $ylist $x2_list, nolog 
estimates store A   
logit aFP cHouseincome, nolog
estimates store C
lrtest A C

logit $ylist $x2_list, nolog 
outreg2 using "C:\Users\Trang Bui\Desktop\TrangBui\Mymod.doc", replace ctitle(Logit coeff) onecol br bdec(4)
predict prlogit
label var prlogit "Logit: Pr(lfp)"
dotplot prlogit, ylabel (0 .2 to 1)
mfx compute
mchange 
listcoef, help

logit $ylist $x2_list if cfemale==1
 outreg2 using "C:\Users\Trang Bui\Desktop\TrangBui\Mymod.doc", append ctitle(For women) onecol br bdec(4)
logit $ylist $x2_list if cfemale==0
outreg2 using "C:\Users\Trang Bui\Desktop\TrangBui\Mymod.doc", append ctitle(For men) onecol br bdec(4)
*oaxaca-Blinder decomposition for financial planning
nldecompose, by(cfemale) regoutput bootstrap:  logit aFP FL1 age_2 age_3 edu_2 edu_3 jobb Houseinc Risk
nldecompose, by(cfemale):  logit aFP FL1 age_2 age_3 edu_2 edu_3 jobb Houseinc Risk

**For saving intention**
logit $zlist $x2_list, nolog
outreg2 using "C:\Users\Trang Bui\Desktop\TrangBui\Mymod1.doc", replace ctitle(Logit coeff) onecol br bdec(4)
estimates store A1 
logit SIN1 cHouseincome, nolog
estimates store C1 
lrtest A1 C1 

logit $zlist $x3_list if cfemale==1, nolog
outreg2 using "C:\Users\Trang Bui\Desktop\TrangBui\Mymod1.doc", append ctitle(Logit coeff) onecol br bdec(4)
logit $zlist $x3_list if cfemale==0, nolog
outreg2 using "C:\Users\Trang Bui\Desktop\TrangBui\Mymod1.doc", append ctitle(Logit coeff) onecol br bdec(4)

*oaxaca-Blinder decomposition for saving intention
nldecompose, by(cfemale) regoutput bootstrap:  logit SIN1 FL1 age_2 age_3 edu_2 edu_3 jobb Houseinc Risk
nldecompose, by(cfemale):  logit SIN1 FL1 age_2 age_3 edu_2 edu_3 jobb Houseinc Risk

**For financial confidence**
ologit $tlist $x2_list, nolog
outreg2 using "C:\Users\Trang Bui\Desktop\TrangBui\Mymod2.doc", replace ctitle(Logit coeff) onecol br bdec(4)

estimates store A2 
ologit bconf1 cHouseincome, nolog
estimates store C2 
lrtest A2 C2 

*test for paralell regression assumption 
ologit $tlist $x2_list, nolog
omodel logit $tlist $x2_list
ologit $tlist $x2_list, nolog
brant, detail 

*Using genralized logit model or partial proportional odds model 
gologit2 $tlist $x2_list, pl lrforce store(constrained)
gologit2 $tlist $x2_list, npl lrforce store(unconstrained)
lrtest constrained unconstrained
gologit2 $wlist $x2_list, autofit lrf
outreg2 using "C:\Users\Trang Bui\Desktop\TrangBui\Mymod2.doc", replace ctitle(Logit coeff) onecol br bdec(4)

predict pcon1 pcon2 pcon3 
dotplot pcon1, ylabel (0 .2 to 1)
dotplot pcon2, ylabel (0 .2 to 1)
dotplot pcon3, ylabel (0 .2 to 1)
mtable
mchange
mfx compute 

gologit2 $wlist $x2_list if cfemale==1, autofit lrf
outreg2 using "C:\Users\Trang Bui\Desktop\TrangBui\Mymod2.doc", append ctitle(Logit coeff) onecol br bdec(4)

gologit2 $wlist $x2_list if cfemale==0, autofit
outreg2 using "C:\Users\Trang Bui\Desktop\TrangBui\Mymod2.doc", append ctitle(Logit coeff) onecol br bdec(4)

*oaxaca-Blinder decomposition for financial confidence 
nldecompose, by(cfemale) regoutput bootstrap:  regress FC_4 FL1 age_2 age_3 edu_2 edu_3 jobb Houseinc Risk
nldecompose, by(cfemale):  regress FC_4 FL1 age_2 age_3 edu_2 edu_3 jobb Houseinc Risk

 
