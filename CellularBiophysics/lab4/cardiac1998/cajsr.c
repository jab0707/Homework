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
 
#define nrn_init _nrn_init__Ca_jsr
#define _nrn_initial _nrn_initial__Ca_jsr
#define nrn_cur _nrn_cur__Ca_jsr
#define _nrn_current _nrn_current__Ca_jsr
#define nrn_jacob _nrn_jacob__Ca_jsr
#define nrn_state _nrn_state__Ca_jsr
#define _net_receive _net_receive__Ca_jsr 
#define evaluate_fct evaluate_fct__Ca_jsr 
#define states states__Ca_jsr 
 
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
#define krel _p[0]
#define Vrel _p[1]
#define Csqn _p[2]
#define Kmcsqn _p[3]
#define m _p[4]
#define n _p[5]
#define h _p[6]
#define Dm _p[7]
#define Dn _p[8]
#define Dh _p[9]
#define ica _p[10]
#define icr _p[11]
#define cai _p[12]
#define cri _p[13]
#define icd _p[14]
#define tadj _p[15]
#define _g _p[16]
#define _ion_icd	*_ppvar[0]._pval
#define _ion_dicddv	*_ppvar[1]._pval
#define _ion_icr	*_ppvar[2]._pval
#define _ion_cri	*_ppvar[3]._pval
#define _ion_dicrdv	*_ppvar[4]._pval
#define _ion_cai	*_ppvar[5]._pval
#define _ion_ica	*_ppvar[6]._pval
 
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
 extern double celsius;
 /* declaration of user functions */
 static void _hoc_expMb(void);
 static void _hoc_expMa(void);
 static void _hoc_evaluate_fct(void);
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
 "setdata_Ca_jsr", _hoc_setdata,
 "expMb_Ca_jsr", _hoc_expMb,
 "expMa_Ca_jsr", _hoc_expMa,
 "evaluate_fct_Ca_jsr", _hoc_evaluate_fct,
 0, 0
};
#define expMb expMb_Ca_jsr
#define expMa expMa_Ca_jsr
 extern double expMb( double , double );
 extern double expMa( double , double );
 /* declare global and static user variables */
#define Tauinactca Tauinactca_Ca_jsr
 double Tauinactca = 1.91;
#define dummy dummy_Ca_jsr
 double dummy = 0;
#define h_exp h_exp_Ca_jsr
 double h_exp = 0;
#define h_inf h_inf_Ca_jsr
 double h_inf = 0;
#define m_exp m_exp_Ca_jsr
 double m_exp = 0;
#define m_inf m_inf_Ca_jsr
 double m_inf = 0;
#define n_exp n_exp_Ca_jsr
 double n_exp = 0;
#define n_inf n_inf_Ca_jsr
 double n_inf = 0;
#define tau_n tau_n_Ca_jsr
 double tau_n = 0;
#define tau_h tau_h_Ca_jsr
 double tau_h = 0;
#define tau_m tau_m_Ca_jsr
 double tau_m = 0;
 /* some parameters have upper and lower limits */
 static HocParmLimits _hoc_parm_limits[] = {
 "krel_Ca_jsr", 0, 1e+009,
 0,0,0
};
 static HocParmUnits _hoc_parm_units[] = {
 "Tauinactca_Ca_jsr", "ms",
 "krel_Ca_jsr", "mse-1",
 "Vrel_Ca_jsr", "cm3",
 "Csqn_Ca_jsr", "mM",
 "Kmcsqn_Ca_jsr", "mM",
 0,0
};
 static double delta_t = 0.01;
 static double h0 = 0;
 static double m0 = 0;
 static double n0 = 0;
 static double v = 0;
 /* connect global user variables to hoc */
 static DoubScal hoc_scdoub[] = {
 "Tauinactca_Ca_jsr", &Tauinactca_Ca_jsr,
 "dummy_Ca_jsr", &dummy_Ca_jsr,
 "m_inf_Ca_jsr", &m_inf_Ca_jsr,
 "h_inf_Ca_jsr", &h_inf_Ca_jsr,
 "n_inf_Ca_jsr", &n_inf_Ca_jsr,
 "tau_m_Ca_jsr", &tau_m_Ca_jsr,
 "tau_h_Ca_jsr", &tau_h_Ca_jsr,
 "tau_n_Ca_jsr", &tau_n_Ca_jsr,
 "m_exp_Ca_jsr", &m_exp_Ca_jsr,
 "h_exp_Ca_jsr", &h_exp_Ca_jsr,
 "n_exp_Ca_jsr", &n_exp_Ca_jsr,
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
 
#define _cvode_ieq _ppvar[7]._i
 static void _ode_matsol_instance1(_threadargsproto_);
 /* connect range variables in _p that hoc is supposed to know about */
 static const char *_mechanism[] = {
 "7.5.0",
"Ca_jsr",
 "krel_Ca_jsr",
 "Vrel_Ca_jsr",
 "Csqn_Ca_jsr",
 "Kmcsqn_Ca_jsr",
 0,
 0,
 "m_Ca_jsr",
 "n_Ca_jsr",
 "h_Ca_jsr",
 0,
 0};
 static Symbol* _cd_sym;
 static Symbol* _cr_sym;
 static Symbol* _ca_sym;
 
extern Prop* need_memb(Symbol*);

static void nrn_alloc(Prop* _prop) {
	Prop *prop_ion;
	double *_p; Datum *_ppvar;
 	_p = nrn_prop_data_alloc(_mechtype, 17, _prop);
 	/*initialize range parameters*/
 	krel = 30;
 	Vrel = 9.648e-011;
 	Csqn = 10;
 	Kmcsqn = 0.8;
 	_prop->param = _p;
 	_prop->param_size = 17;
 	_ppvar = nrn_prop_datum_alloc(_mechtype, 8, _prop);
 	_prop->dparam = _ppvar;
 	/*connect ionic variables to this model*/
 prop_ion = need_memb(_cd_sym);
 	_ppvar[0]._pval = &prop_ion->param[3]; /* icd */
 	_ppvar[1]._pval = &prop_ion->param[4]; /* _ion_dicddv */
 prop_ion = need_memb(_cr_sym);
 nrn_promote(prop_ion, 1, 0);
 	_ppvar[2]._pval = &prop_ion->param[3]; /* icr */
 	_ppvar[3]._pval = &prop_ion->param[1]; /* cri */
 	_ppvar[4]._pval = &prop_ion->param[4]; /* _ion_dicrdv */
 prop_ion = need_memb(_ca_sym);
 nrn_promote(prop_ion, 1, 0);
 	_ppvar[5]._pval = &prop_ion->param[1]; /* cai */
 	_ppvar[6]._pval = &prop_ion->param[3]; /* ica */
 
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

 void _cajsr_reg() {
	int _vectorized = 0;
  _initlists();
 	ion_reg("cd", 2.0);
 	ion_reg("cr", 2.0);
 	ion_reg("ca", -10000.);
 	_cd_sym = hoc_lookup("cd_ion");
 	_cr_sym = hoc_lookup("cr_ion");
 	_ca_sym = hoc_lookup("ca_ion");
 	register_mech(_mechanism, nrn_alloc,nrn_cur, nrn_jacob, nrn_state, nrn_init, hoc_nrnpointerindex, 0);
 _mechtype = nrn_get_mechtype(_mechanism[1]);
     _nrn_setdata_reg(_mechtype, _setdata);
     _nrn_thread_reg(_mechtype, 2, _update_ion_pointer);
  hoc_register_prop_size(_mechtype, 17, 8);
  hoc_register_dparam_semantics(_mechtype, 0, "cd_ion");
  hoc_register_dparam_semantics(_mechtype, 1, "cd_ion");
  hoc_register_dparam_semantics(_mechtype, 2, "cr_ion");
  hoc_register_dparam_semantics(_mechtype, 3, "cr_ion");
  hoc_register_dparam_semantics(_mechtype, 4, "cr_ion");
  hoc_register_dparam_semantics(_mechtype, 5, "ca_ion");
  hoc_register_dparam_semantics(_mechtype, 6, "ca_ion");
  hoc_register_dparam_semantics(_mechtype, 7, "cvodeieq");
 	hoc_register_cvode(_mechtype, _ode_count, _ode_map, _ode_spec, _ode_matsol);
 	hoc_register_tolerance(_mechtype, _hoc_state_tol, &_atollist);
 	hoc_register_var(hoc_scdoub, hoc_vdoub, hoc_intfunc);
 	ivoc_help("help ?1 Ca_jsr C:/Users/Jake/Documents/GitHub/Homework/Homework/CellularBiophysics/lab4/cardiac1998/cajsr.mod\n");
 hoc_register_limits(_mechtype, _hoc_parm_limits);
 hoc_register_units(_mechtype, _hoc_parm_units);
 }
static int _reset;
static char *modelname = "Calcium release from JSR";

static int error;
static int _ninits = 0;
static int _match_recurse=1;
static void _modl_cleanup(){ _match_recurse=1;}
static int evaluate_fct(double, double, double);
 static int _deriv1_advance = 0;
 
static int _ode_spec1(_threadargsproto_);
/*static int _ode_matsol1(_threadargsproto_);*/
 static int _slist2[3]; static double _dlist2[3];
 static double _savstate1[3], *_temp1 = _savstate1;
 static int _slist1[3], _dlist1[3];
 static int states(_threadargsproto_);
 
/*CVODE*/
 static int _ode_spec1 () {_reset=0;
 {
   evaluate_fct ( _threadargscomma_ icr , ica , v ) ;
   Dm = ( m_inf - m ) / tau_m ;
   Dn = ( n_inf - n ) / tau_n ;
   Dh = ( h_inf - h ) / tau_h ;
   }
 return _reset;
}
 static int _ode_matsol1 () {
 evaluate_fct ( _threadargscomma_ icr , ica , v ) ;
 Dm = Dm  / (1. - dt*( ( ( ( - 1.0 ) ) ) / tau_m )) ;
 Dn = Dn  / (1. - dt*( ( ( ( - 1.0 ) ) ) / tau_n )) ;
 Dh = Dh  / (1. - dt*( ( ( ( - 1.0 ) ) ) / tau_h )) ;
  return 0;
}
 /*END CVODE*/
 
static int states () {_reset=0;
 { static int _recurse = 0;
 int _counte = -1;
 if (!_recurse) {
 _recurse = 1;
 {int _id; for(_id=0; _id < 3; _id++) { _savstate1[_id] = _p[_slist1[_id]];}}
 error = newton(3,_slist2, _p, states, _dlist2);
 _recurse = 0; if(error) {abort_run(error);}}
 {
   evaluate_fct ( _threadargscomma_ icr , ica , v ) ;
   Dm = ( m_inf - m ) / tau_m ;
   Dn = ( n_inf - n ) / tau_n ;
   Dh = ( h_inf - h ) / tau_h ;
   {int _id; for(_id=0; _id < 3; _id++) {
if (_deriv1_advance) {
 _dlist2[++_counte] = _p[_dlist1[_id]] - (_p[_slist1[_id]] - _savstate1[_id])/dt;
 }else{
_dlist2[++_counte] = _p[_slist1[_id]] - _savstate1[_id];}}}
 } }
 return _reset;}
 
static int  evaluate_fct (  double _licr , double _lica , double _lv ) {
   double _la , _lb , _lq10 ;
 _lq10 = pow( 3.0 , ( ( celsius - 37.0 ) / 10.0 ) ) ;
   _la = 1.0 / ( 1.0 + expMa ( _threadargscomma_ ( Vrel * _licr - _lica / 0.96480 * 100.0 - 3.4175e-1 ) , ( 13.67e-4 ) ) ) ;
   _lb = 8.0 / ( _lq10 * 1.0 ) ;
   tau_m = _lb ;
   m_inf = _la ;
   _la = ( 1.0 - 1.0 / ( 1.0 + expMb ( _threadargscomma_ ( Vrel * _licr - _lica / 0.96480 * 100.0 - 6.835e-2 ) , ( 13.67e-4 ) ) ) ) ;
   _lb = _lq10 * 1.0 * ( Tauinactca + 2.09 / ( 1.0 + expMa ( _threadargscomma_ ( Vrel * _licr - _lica / 0.96480 * 100.0 - 3.4175e-1 ) , ( 13.67e-4 ) ) ) ) ;
   tau_n = _lb ;
   n_inf = _la ;
   _la = ( 1.0 - 1.0 / ( 1.0 + exp ( - ( _lv - 40.0 ) / 17.0 ) ) ) ;
   _lb = 6.0 * ( 1.0 - exp ( - ( _lv - 7.9 ) / 5.0 ) ) / ( ( 1.0 + 0.3 * exp ( - ( _lv - 7.9 ) / 5.0 ) ) * ( _lv - 7.9 ) ) / ( _lq10 * 1.0 ) ;
   tau_h = _lb ;
   h_inf = _la ;
    return 0; }
 
static void _hoc_evaluate_fct(void) {
  double _r;
   _r = 1.;
 evaluate_fct (  *getarg(1) , *getarg(2) , *getarg(3) );
 hoc_retpushx(_r);
}
 
double expMa (  double _lx , double _ly ) {
   double _lexpMa;
 if ( fabs ( _lx / _ly ) < 1e-6 ) {
     _lexpMa = ( 1.0 - _lx / _ly / 2.0 ) ;
     }
   else {
     _lexpMa = exp ( - _lx / _ly ) ;
     }
   
return _lexpMa;
 }
 
static void _hoc_expMa(void) {
  double _r;
   _r =  expMa (  *getarg(1) , *getarg(2) );
 hoc_retpushx(_r);
}
 
double expMb (  double _lx , double _ly ) {
   double _lexpMb;
 if ( fabs ( _lx / _ly ) < 1e-6 ) {
     _lexpMb = ( 1.0 - _lx / _ly / 2.0 ) ;
     }
   else {
     _lexpMb = exp ( - _lx / _ly ) ;
     }
   
return _lexpMb;
 }
 
static void _hoc_expMb(void) {
  double _r;
   _r =  expMb (  *getarg(1) , *getarg(2) );
 hoc_retpushx(_r);
}
 
static int _ode_count(int _type){ return 3;}
 
static void _ode_spec(_NrnThread* _nt, _Memb_list* _ml, int _type) {
   Datum* _thread;
   Node* _nd; double _v; int _iml, _cntml;
  _cntml = _ml->_nodecount;
  _thread = _ml->_thread;
  for (_iml = 0; _iml < _cntml; ++_iml) {
    _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
    _nd = _ml->_nodelist[_iml];
    v = NODEV(_nd);
  icr = _ion_icr;
  cri = _ion_cri;
  cai = _ion_cai;
  ica = _ion_ica;
     _ode_spec1 ();
   }}
 
static void _ode_map(int _ieq, double** _pv, double** _pvdot, double* _pp, Datum* _ppd, double* _atol, int _type) { 
 	int _i; _p = _pp; _ppvar = _ppd;
	_cvode_ieq = _ieq;
	for (_i=0; _i < 3; ++_i) {
		_pv[_i] = _pp + _slist1[_i];  _pvdot[_i] = _pp + _dlist1[_i];
		_cvode_abstol(_atollist, _atol, _i);
	}
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
  icr = _ion_icr;
  cri = _ion_cri;
  cai = _ion_cai;
  ica = _ion_ica;
 _ode_matsol_instance1(_threadargs_);
 }}
 extern void nrn_update_ion_pointer(Symbol*, Datum*, int, int);
 static void _update_ion_pointer(Datum* _ppvar) {
   nrn_update_ion_pointer(_cd_sym, _ppvar, 0, 3);
   nrn_update_ion_pointer(_cd_sym, _ppvar, 1, 4);
   nrn_update_ion_pointer(_cr_sym, _ppvar, 2, 3);
   nrn_update_ion_pointer(_cr_sym, _ppvar, 3, 1);
   nrn_update_ion_pointer(_cr_sym, _ppvar, 4, 4);
   nrn_update_ion_pointer(_ca_sym, _ppvar, 5, 1);
   nrn_update_ion_pointer(_ca_sym, _ppvar, 6, 3);
 }

static void initmodel() {
  int _i; double _save;_ninits++;
 _save = t;
 t = 0.0;
{
  h = h0;
  m = m0;
  n = n0;
 {
   evaluate_fct ( _threadargscomma_ icr , ica , v ) ;
   m = m_inf ;
   n = n_inf ;
   h = h_inf ;
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
  icr = _ion_icr;
  cri = _ion_cri;
  cai = _ion_cai;
  ica = _ion_ica;
 initmodel();
  }}

static double _nrn_current(double _v){double _current=0.;v=_v;{ {
   icr = krel * m * m * n * h * ( cri - cai ) ;
   icd = - icr ;
   }
 _current += icd;
 _current += icr;

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
  icr = _ion_icr;
  cri = _ion_cri;
  cai = _ion_cai;
  ica = _ion_ica;
if (_nt->_vcv) { _ode_spec1(); }
 _g = _nrn_current(_v + .001);
 	{ double _dicr;
 double _dicd;
  _dicd = icd;
  _dicr = icr;
 _rhs = _nrn_current(_v);
  _ion_dicddv += (_dicd - icd)/.001 ;
  _ion_dicrdv += (_dicr - icr)/.001 ;
 	}
 _g = (_g - _rhs)/.001;
  _ion_icd += icd ;
  _ion_icr += icr ;
#if CACHEVEC
  if (use_cachevec) {
	VEC_RHS(_ni[_iml]) -= _rhs;
  }else
#endif
  {
	NODERHS(_nd) -= _rhs;
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
  icr = _ion_icr;
  cri = _ion_cri;
  cai = _ion_cai;
  ica = _ion_ica;
 { error = _deriv1_advance = 1;
 derivimplicit(_ninits, 3, _slist1, _dlist1, _p, &t, dt, states, &_temp1);
_deriv1_advance = 0;
 if(error){fprintf(stderr,"at line 48 in file cajsr.mod:\n	\n"); nrn_complain(_p); abort_run(error);}
    if (secondorder) {
    int _i;
    for (_i = 0; _i < 3; ++_i) {
      _p[_slist1[_i]] += dt*_p[_dlist1[_i]];
    }}
 }  }}
 dt = _dtsav;
}

static void terminal(){}

static void _initlists() {
 int _i; static int _first = 1;
  if (!_first) return;
 _slist1[0] = &(m) - _p;  _dlist1[0] = &(Dm) - _p;
 _slist1[1] = &(n) - _p;  _dlist1[1] = &(Dn) - _p;
 _slist1[2] = &(h) - _p;  _dlist1[2] = &(Dh) - _p;
 _slist2[0] = &(h) - _p;
 _slist2[1] = &(m) - _p;
 _slist2[2] = &(n) - _p;
_first = 0;
}
