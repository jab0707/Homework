/* Created by Language version: 7.5.0 */
/* NOT VECTORIZED */
#define NRN_VECTORIZED 0
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "scoplib_ansi.h"
#undef PI
#define nil 0
#include "md1redef.h"
#include "section.h"
#include "nrniv_mf.h"
#include "md2redef.h"
 
#if METHOD3
extern int _method3;
#endif

#if !NRNGPU
#undef exp
#define exp hoc_Exp
extern double hoc_Exp(double);
#endif
 
#define nrn_init _nrn_init__Cadynam
#define _nrn_initial _nrn_initial__Cadynam
#define nrn_cur _nrn_cur__Cadynam
#define _nrn_current _nrn_current__Cadynam
#define nrn_jacob _nrn_jacob__Cadynam
#define nrn_state _nrn_state__Cadynam
#define _net_receive _net_receive__Cadynam 
#define state state__Cadynam 
 
#define _threadargscomma_ /**/
#define _threadargsprotocomma_ /**/
#define _threadargs_ /**/
#define _threadargsproto_ /**/
 	/*SUPPRESS 761*/
	/*SUPPRESS 762*/
	/*SUPPRESS 763*/
	/*SUPPRESS 765*/
	 extern double *getarg();
 static double *_p; static Datum *_ppvar;
 
#define t nrn_threads->_t
#define dt nrn_threads->_dt
#define Vi _p[0]
#define Vup _p[1]
#define Vrel _p[2]
#define Trpn _p[3]
#define Kmtrpn _p[4]
#define Cmdn _p[5]
#define Kmcmdn _p[6]
#define cupmax _p[7]
#define Kup _p[8]
#define icr _p[9]
#define ica _p[10]
#define cui _p[11]
#define cri _p[12]
#define cai _p[13]
#define Dcai _p[14]
#define _g _p[15]
#define _ion_ica	*_ppvar[0]._pval
#define _ion_cai	*_ppvar[1]._pval
#define _style_ca	*((int*)_ppvar[2]._pvoid)
#define _ion_cui	*_ppvar[3]._pval
#define _ion_icr	*_ppvar[4]._pval
#define _ion_cri	*_ppvar[5]._pval
 
#if MAC
#if !defined(v)
#define v _mlhv
#endif
#if !defined(h)
#define h _mlhh
#endif
#endif
 
#if defined(__cplusplus)
extern "C" {
#endif
 static int hoc_nrnpointerindex =  -1;
 /* external NEURON variables */
 /* declaration of user functions */
 static int _mechtype;
extern void _nrn_cacheloop_reg(int, int);
extern void hoc_register_prop_size(int, int, int);
extern void hoc_register_limits(int, HocParmLimits*);
extern void hoc_register_units(int, HocParmUnits*);
extern void nrn_promote(Prop*, int, int);
extern Memb_func* memb_func;
 extern void _nrn_setdata_reg(int, void(*)(Prop*));
 static void _setdata(Prop* _prop) {
 _p = _prop->param; _ppvar = _prop->dparam;
 }
 static void _hoc_setdata() {
 Prop *_prop, *hoc_getdata_range(int);
 _prop = hoc_getdata_range(_mechtype);
   _setdata(_prop);
 hoc_retpushx(1.);
}
 /* connect user functions to hoc names */
 static VoidFunc hoc_intfunc[] = {
 "setdata_Cadynam", _hoc_setdata,
 0, 0
};
 /* declare global and static user variables */
#define Iupmax Iupmax_Cadynam
 double Iupmax = 0.005;
 /* some parameters have upper and lower limits */
 static HocParmLimits _hoc_parm_limits[] = {
 0,0,0
};
 static HocParmUnits _hoc_parm_units[] = {
 "Iupmax_Cadynam", "mM/ms",
 "Vi_Cadynam", "cm3",
 "Vup_Cadynam", "cm3",
 "Vrel_Cadynam", "cm3",
 "Trpn_Cadynam", "mM",
 "Kmtrpn_Cadynam", "mM",
 "Cmdn_Cadynam", "mM",
 "Kmcmdn_Cadynam", "mM",
 "cupmax_Cadynam", "mM",
 "Kup_Cadynam", "mM",
 0,0
};
 static double cai0 = 0.0001;
 static double delta_t = 0.01;
 static double v = 0;
 /* connect global user variables to hoc */
 static DoubScal hoc_scdoub[] = {
 "Iupmax_Cadynam", &Iupmax_Cadynam,
 0,0
};
 static DoubVec hoc_vdoub[] = {
 0,0,0
};
 static double _sav_indep;
 static void nrn_alloc(Prop*);
static void  nrn_init(_NrnThread*, _Memb_list*, int);
static void nrn_state(_NrnThread*, _Memb_list*, int);
 static void nrn_cur(_NrnThread*, _Memb_list*, int);
static void  nrn_jacob(_NrnThread*, _Memb_list*, int);
 
static int _ode_count(int);
static void _ode_map(int, double**, double**, double*, Datum*, double*, int);
static void _ode_spec(_NrnThread*, _Memb_list*, int);
static void _ode_matsol(_NrnThread*, _Memb_list*, int);
 
#define _cvode_ieq _ppvar[6]._i
 static void _ode_matsol_instance1(_threadargsproto_);
 /* connect range variables in _p that hoc is supposed to know about */
 static const char *_mechanism[] = {
 "7.5.0",
"Cadynam",
 "Vi_Cadynam",
 "Vup_Cadynam",
 "Vrel_Cadynam",
 "Trpn_Cadynam",
 "Kmtrpn_Cadynam",
 "Cmdn_Cadynam",
 "Kmcmdn_Cadynam",
 "cupmax_Cadynam",
 "Kup_Cadynam",
 0,
 0,
 0,
 0};
 static Symbol* _ca_sym;
 static Symbol* _cu_sym;
 static Symbol* _cr_sym;
 
extern Prop* need_memb(Symbol*);

static void nrn_alloc(Prop* _prop) {
	Prop *prop_ion;
	double *_p; Datum *_ppvar;
 	_p = nrn_prop_data_alloc(_mechtype, 16, _prop);
 	/*initialize range parameters*/
 	Vi = 1.3668e-008;
 	Vup = 1.10952e-009;
 	Vrel = 9.648e-011;
 	Trpn = 0.07;
 	Kmtrpn = 0.0005;
 	Cmdn = 0.05;
 	Kmcmdn = 0.00238;
 	cupmax = 15;
 	Kup = 0.00092;
 	_prop->param = _p;
 	_prop->param_size = 16;
 	_ppvar = nrn_prop_datum_alloc(_mechtype, 7, _prop);
 	_prop->dparam = _ppvar;
 	/*connect ionic variables to this model*/
 prop_ion = need_memb(_ca_sym);
 nrn_check_conc_write(_prop, prop_ion, 1);
 nrn_promote(prop_ion, 3, 0);
 	_ppvar[0]._pval = &prop_ion->param[3]; /* ica */
 	_ppvar[1]._pval = &prop_ion->param[1]; /* cai */
 	_ppvar[2]._pvoid = (void*)(&(prop_ion->dparam[0]._i)); /* iontype for ca */
 prop_ion = need_memb(_cu_sym);
 nrn_promote(prop_ion, 1, 0);
 	_ppvar[3]._pval = &prop_ion->param[1]; /* cui */
 prop_ion = need_memb(_cr_sym);
 nrn_promote(prop_ion, 1, 0);
 	_ppvar[4]._pval = &prop_ion->param[3]; /* icr */
 	_ppvar[5]._pval = &prop_ion->param[1]; /* cri */
 
}
 static void _initlists();
  /* some states have an absolute tolerance */
 static Symbol** _atollist;
 static HocStateTolerance _hoc_state_tol[] = {
 0,0
};
 static void _update_ion_pointer(Datum*);
 extern Symbol* hoc_lookup(const char*);
extern void _nrn_thread_reg(int, int, void(*)(Datum*));
extern void _nrn_thread_table_reg(int, void(*)(double*, Datum*, Datum*, _NrnThread*, int));
extern void hoc_register_tolerance(int, HocStateTolerance*, Symbol***);
extern void _cvode_abstol( Symbol**, double*, int);

 void _cadynam_reg() {
	int _vectorized = 0;
  _initlists();
 	ion_reg("ca", -10000.);
 	ion_reg("cu", 2.0);
 	ion_reg("cr", 2.0);
 	_ca_sym = hoc_lookup("ca_ion");
 	_cu_sym = hoc_lookup("cu_ion");
 	_cr_sym = hoc_lookup("cr_ion");
 	register_mech(_mechanism, nrn_alloc,nrn_cur, nrn_jacob, nrn_state, nrn_init, hoc_nrnpointerindex, 0);
 _mechtype = nrn_get_mechtype(_mechanism[1]);
     _nrn_setdata_reg(_mechtype, _setdata);
     _nrn_thread_reg(_mechtype, 2, _update_ion_pointer);
  hoc_register_prop_size(_mechtype, 16, 7);
  hoc_register_dparam_semantics(_mechtype, 0, "ca_ion");
  hoc_register_dparam_semantics(_mechtype, 1, "ca_ion");
  hoc_register_dparam_semantics(_mechtype, 2, "#ca_ion");
  hoc_register_dparam_semantics(_mechtype, 3, "cu_ion");
  hoc_register_dparam_semantics(_mechtype, 4, "cr_ion");
  hoc_register_dparam_semantics(_mechtype, 5, "cr_ion");
  hoc_register_dparam_semantics(_mechtype, 6, "cvodeieq");
 	nrn_writes_conc(_mechtype, 0);
 	hoc_register_cvode(_mechtype, _ode_count, _ode_map, _ode_spec, _ode_matsol);
 	hoc_register_tolerance(_mechtype, _hoc_state_tol, &_atollist);
 	hoc_register_var(hoc_scdoub, hoc_vdoub, hoc_intfunc);
 	ivoc_help("help ?1 Cadynam C:/Users/Jake/Documents/GitHub/Homework/Homework/CellularBiophysics/lab4/cardiac1998/cadynam.mod\n");
 hoc_register_limits(_mechtype, _hoc_parm_limits);
 hoc_register_units(_mechtype, _hoc_parm_units);
 }
 static double F = 96485.3;
 static double _zViF , _zVuP , _zVeR ;
static int _reset;
static char *modelname = "";

static int error;
static int _ninits = 0;
static int _match_recurse=1;
static void _modl_cleanup(){ _match_recurse=1;}
 static int _deriv1_advance = 0;
 
static int _ode_spec1(_threadargsproto_);
/*static int _ode_matsol1(_threadargsproto_);*/
 static int _slist2[1]; static double _dlist2[1];
 static double _savstate1[1], *_temp1 = _savstate1;
 static int _slist1[1], _dlist1[1];
 static int state(_threadargsproto_);
 
/*CVODE*/
 static int _ode_spec1 () {_reset=0;
 {
   Dcai = ( - 0.5 * ica / ( _zViF ) + _zVuP * ( cui * Iupmax / cupmax - Iupmax / ( 1.0 + ( Kup / cai ) ) ) + 0.5 * icr * _zVeR ) / ( 1.0 + Trpn * Kmtrpn / ( ( cai + Kmtrpn ) * ( cai + Kmtrpn ) ) + Cmdn * Kmcmdn / ( ( cai + Kmcmdn ) * ( cai + Kmcmdn ) ) ) ;
   }
 return _reset;
}
 static int _ode_matsol1 () {
 Dcai = Dcai  / (1. - dt*( (( ( - 0.5 * ica / ( _zViF ) + _zVuP * ( cui * Iupmax / cupmax - Iupmax / ( 1.0 + ( Kup / ( cai  + .001) ) ) ) + 0.5 * icr * _zVeR ) / ( 1.0 + Trpn * Kmtrpn / ( ( ( cai  + .001) + Kmtrpn ) * ( ( cai  + .001) + Kmtrpn ) ) + Cmdn * Kmcmdn / ( ( ( cai  + .001) + Kmcmdn ) * ( ( cai  + .001) + Kmcmdn ) ) ) ) - ( ( - 0.5 * ica / ( _zViF ) + _zVuP * ( cui * Iupmax / cupmax - Iupmax / ( 1.0 + ( Kup / cai ) ) ) + 0.5 * icr * _zVeR ) / ( 1.0 + Trpn * Kmtrpn / ( ( cai + Kmtrpn ) * ( cai + Kmtrpn ) ) + Cmdn * Kmcmdn / ( ( cai + Kmcmdn ) * ( cai + Kmcmdn ) ) )  )) / .001 )) ;
  return 0;
}
 /*END CVODE*/
 
static int state () {_reset=0;
 { static int _recurse = 0;
 int _counte = -1;
 if (!_recurse) {
 _recurse = 1;
 {int _id; for(_id=0; _id < 1; _id++) { _savstate1[_id] = _p[_slist1[_id]];}}
 error = newton(1,_slist2, _p, state, _dlist2);
 _recurse = 0; if(error) {abort_run(error);}}
 {
   Dcai = ( - 0.5 * ica / ( _zViF ) + _zVuP * ( cui * Iupmax / cupmax - Iupmax / ( 1.0 + ( Kup / cai ) ) ) + 0.5 * icr * _zVeR ) / ( 1.0 + Trpn * Kmtrpn / ( ( cai + Kmtrpn ) * ( cai + Kmtrpn ) ) + Cmdn * Kmcmdn / ( ( cai + Kmcmdn ) * ( cai + Kmcmdn ) ) ) ;
   {int _id; for(_id=0; _id < 1; _id++) {
if (_deriv1_advance) {
 _dlist2[++_counte] = _p[_dlist1[_id]] - (_p[_slist1[_id]] - _savstate1[_id])/dt;
 }else{
_dlist2[++_counte] = _p[_slist1[_id]] - _savstate1[_id];}}}
 } }
 return _reset;}
 
static int _ode_count(int _type){ return 1;}
 
static void _ode_spec(_NrnThread* _nt, _Memb_list* _ml, int _type) {
   Datum* _thread;
   Node* _nd; double _v; int _iml, _cntml;
  _cntml = _ml->_nodecount;
  _thread = _ml->_thread;
  for (_iml = 0; _iml < _cntml; ++_iml) {
    _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
    _nd = _ml->_nodelist[_iml];
    v = NODEV(_nd);
  ica = _ion_ica;
  cai = _ion_cai;
  cai = _ion_cai;
  cui = _ion_cui;
  icr = _ion_icr;
  cri = _ion_cri;
     _ode_spec1 ();
  _ion_cai = cai;
 }}
 
static void _ode_map(int _ieq, double** _pv, double** _pvdot, double* _pp, Datum* _ppd, double* _atol, int _type) { 
 	int _i; _p = _pp; _ppvar = _ppd;
	_cvode_ieq = _ieq;
	for (_i=0; _i < 1; ++_i) {
		_pv[_i] = _pp + _slist1[_i];  _pvdot[_i] = _pp + _dlist1[_i];
		_cvode_abstol(_atollist, _atol, _i);
	}
 	_pv[0] = &(_ion_cai);
 }
 
static void _ode_matsol_instance1(_threadargsproto_) {
 _ode_matsol1 ();
 }
 
static void _ode_matsol(_NrnThread* _nt, _Memb_list* _ml, int _type) {
   Datum* _thread;
   Node* _nd; double _v; int _iml, _cntml;
  _cntml = _ml->_nodecount;
  _thread = _ml->_thread;
  for (_iml = 0; _iml < _cntml; ++_iml) {
    _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
    _nd = _ml->_nodelist[_iml];
    v = NODEV(_nd);
  ica = _ion_ica;
  cai = _ion_cai;
  cai = _ion_cai;
  cui = _ion_cui;
  icr = _ion_icr;
  cri = _ion_cri;
 _ode_matsol_instance1(_threadargs_);
 }}
 extern void nrn_update_ion_pointer(Symbol*, Datum*, int, int);
 static void _update_ion_pointer(Datum* _ppvar) {
   nrn_update_ion_pointer(_ca_sym, _ppvar, 0, 3);
   nrn_update_ion_pointer(_ca_sym, _ppvar, 1, 1);
   nrn_update_ion_pointer(_cu_sym, _ppvar, 3, 1);
   nrn_update_ion_pointer(_cr_sym, _ppvar, 4, 3);
   nrn_update_ion_pointer(_cr_sym, _ppvar, 5, 1);
 }

static void initmodel() {
  int _i; double _save;_ninits++;
 _save = t;
 t = 0.0;
{
 {
   
/*VERBATIM*/
	cai = _ion_cai;
	
 _zViF = Vi * F * 2e4 ;
   _zVuP = Vup / Vi ;
   _zVeR = Vrel / Vi ;
   }
  _sav_indep = t; t = _save;

}
}

static void nrn_init(_NrnThread* _nt, _Memb_list* _ml, int _type){
Node *_nd; double _v; int* _ni; int _iml, _cntml;
#if CACHEVEC
    _ni = _ml->_nodeindices;
#endif
_cntml = _ml->_nodecount;
for (_iml = 0; _iml < _cntml; ++_iml) {
 _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
#if CACHEVEC
  if (use_cachevec) {
    _v = VEC_V(_ni[_iml]);
  }else
#endif
  {
    _nd = _ml->_nodelist[_iml];
    _v = NODEV(_nd);
  }
 v = _v;
  ica = _ion_ica;
  cai = _ion_cai;
  cai = _ion_cai;
  cui = _ion_cui;
  icr = _ion_icr;
  cri = _ion_cri;
 initmodel();
  _ion_cai = cai;
  nrn_wrote_conc(_ca_sym, (&(_ion_cai)) - 1, _style_ca);
}}

static double _nrn_current(double _v){double _current=0.;v=_v;{
} return _current;
}

static void nrn_cur(_NrnThread* _nt, _Memb_list* _ml, int _type){
Node *_nd; int* _ni; double _rhs, _v; int _iml, _cntml;
#if CACHEVEC
    _ni = _ml->_nodeindices;
#endif
_cntml = _ml->_nodecount;
for (_iml = 0; _iml < _cntml; ++_iml) {
 _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
#if CACHEVEC
  if (use_cachevec) {
    _v = VEC_V(_ni[_iml]);
  }else
#endif
  {
    _nd = _ml->_nodelist[_iml];
    _v = NODEV(_nd);
  }
 
}}

static void nrn_jacob(_NrnThread* _nt, _Memb_list* _ml, int _type){
Node *_nd; int* _ni; int _iml, _cntml;
#if CACHEVEC
    _ni = _ml->_nodeindices;
#endif
_cntml = _ml->_nodecount;
for (_iml = 0; _iml < _cntml; ++_iml) {
 _p = _ml->_data[_iml];
#if CACHEVEC
  if (use_cachevec) {
	VEC_D(_ni[_iml]) += _g;
  }else
#endif
  {
     _nd = _ml->_nodelist[_iml];
	NODED(_nd) += _g;
  }
 
}}

static void nrn_state(_NrnThread* _nt, _Memb_list* _ml, int _type){
Node *_nd; double _v = 0.0; int* _ni; int _iml, _cntml;
double _dtsav = dt;
if (secondorder) { dt *= 0.5; }
#if CACHEVEC
    _ni = _ml->_nodeindices;
#endif
_cntml = _ml->_nodecount;
for (_iml = 0; _iml < _cntml; ++_iml) {
 _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
 _nd = _ml->_nodelist[_iml];
#if CACHEVEC
  if (use_cachevec) {
    _v = VEC_V(_ni[_iml]);
  }else
#endif
  {
    _nd = _ml->_nodelist[_iml];
    _v = NODEV(_nd);
  }
 v=_v;
{
  ica = _ion_ica;
  cai = _ion_cai;
  cai = _ion_cai;
  cui = _ion_cui;
  icr = _ion_icr;
  cri = _ion_cri;
 { error = _deriv1_advance = 1;
 derivimplicit(_ninits, 1, _slist1, _dlist1, _p, &t, dt, state, &_temp1);
_deriv1_advance = 0;
 if(error){fprintf(stderr,"at line 54 in file cadynam.mod:\n	SOLVE state METHOD derivimplicit\n"); nrn_complain(_p); abort_run(error);}
    if (secondorder) {
    int _i;
    for (_i = 0; _i < 1; ++_i) {
      _p[_slist1[_i]] += dt*_p[_dlist1[_i]];
    }}
 } {
   }
  _ion_cai = cai;
}}
 dt = _dtsav;
}

static void terminal(){}

static void _initlists() {
 int _i; static int _first = 1;
  if (!_first) return;
 _slist1[0] = &(cai) - _p;  _dlist1[0] = &(Dcai) - _p;
 _slist2[0] = &(cai) - _p;
_first = 0;
}
