#include <stdio.h>
#include "hocdec.h"
#define IMPORT extern __declspec(dllimport)
IMPORT int nrnmpi_myid, nrn_nobanner_;

extern void _cadynam_reg();
extern void _cajsr_reg();
extern void _cajsracc_reg();
extern void _cansracc_reg();
extern void _capump_reg();
extern void _ical_reg();
extern void _ik1_reg();
extern void _ikr_reg();
extern void _iks_reg();
extern void _ikur_reg();
extern void _inaf_reg();
extern void _ionback_reg();
extern void _ito_reg();
extern void _kcum_reg();
extern void _nacaex_reg();
extern void _nacum_reg();
extern void _nipace_reg();
extern void _nkpump_reg();

modl_reg(){
	//nrn_mswindll_stdio(stdin, stdout, stderr);
    if (!nrn_nobanner_) if (nrnmpi_myid < 1) {
	fprintf(stderr, "Additional mechanisms from files\n");

fprintf(stderr," cadynam.mod");
fprintf(stderr," cajsr.mod");
fprintf(stderr," cajsracc.mod");
fprintf(stderr," cansracc.mod");
fprintf(stderr," capump.mod");
fprintf(stderr," ical.mod");
fprintf(stderr," ik1.mod");
fprintf(stderr," ikr.mod");
fprintf(stderr," iks.mod");
fprintf(stderr," ikur.mod");
fprintf(stderr," inaf.mod");
fprintf(stderr," ionback.mod");
fprintf(stderr," ito.mod");
fprintf(stderr," kcum.mod");
fprintf(stderr," nacaex.mod");
fprintf(stderr," nacum.mod");
fprintf(stderr," nipace.mod");
fprintf(stderr," nkpump.mod");
fprintf(stderr, "\n");
    }
_cadynam_reg();
_cajsr_reg();
_cajsracc_reg();
_cansracc_reg();
_capump_reg();
_ical_reg();
_ik1_reg();
_ikr_reg();
_iks_reg();
_ikur_reg();
_inaf_reg();
_ionback_reg();
_ito_reg();
_kcum_reg();
_nacaex_reg();
_nacum_reg();
_nipace_reg();
_nkpump_reg();
}
