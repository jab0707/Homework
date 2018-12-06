#include <Python.h>
#include <cstdint>
#include <cmath>
#include "sudoku.h"


static int example(int number)
{
        return number;
}

static PyObject *module_example(PyObject *self, PyObject *argument)
{
        int number = PyLong_AsLong(argument);
        int result = example(number);
        return PyLong_FromLong(result);
}


static PyMethodDef module_methods[] = {        
        { "example", (PyCFunction)module_example, METH_O, "Example function" },
        
        // terminate the array with an object containing NULL
        { NULL, NULL, 0, NULL },
};

static PyModuleDef module = {
	PyModuleDef_HEAD_INIT,
	"module",                       // module name
	"Examples of extending python", // module description
	0,                              // keeping no state in the module (size of storage is 0)
	module_methods,                 // structure that defines the methods
};

PyMODINIT_FUNC PyInit_module()
{
	return PyModule_Create(&module);
}