// Header  : libcmsg
// Purpose : C headers for libcmsg
//
// Copyright 2021 Rich Townsend & The MSG Team
//
// This file is part of MSG. MSG is free software: you can redistribute
// it and/or modify it under the terms of the GNU General Public
// License as published by the Free Software Foundation, version 3.
//
// MSG is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
// or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
// License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

#include "stdbool.h"

void *specgrid_load(const char *filename);

void *specgrid_load_rebin(const char *filename, double w_0, double dw, int n_w);

void specgrid_unload(void *ptr);

void specgrid_inquire(void *ptr, double *w_0, double *dw, int *n_w, int *shape, int *rank);

void specgrid_get_label(void *ptr, int i, char *label);

void specgrid_interp_intensity(void *ptr, double vx[], double mu, double w_0, int n_w, 
			       double I[], int *stat, bool vderiv[]);
void specgrid_interp_d_moment(void *ptr, double vx[], int l, double w_0, int n_w, 
			      double D[], int *stat, bool vderiv[]);
void specgrid_interp_flux(void *ptr, double vx[], double w_0, int n_w, 
			  double F[], int *stat, bool vderiv[]);


void *photgrid_load(const char *filename);

void photgrid_unload(void *ptr);

void photgrid_inquire(void *ptr, int *shape, int *rank);

void photgrid_get_label(void *ptr, int i, char *label);

void photgrid_interp_intensity(void *ptr, double vx[], double mu, 
			       double *I, int *stat, bool vderiv[]);

void photgrid_interp_d_moment(void *ptr, double vx[], int l,
			      double *D, int *stat, bool vderiv[]);

void photgrid_interp_flux(void *ptr, double vx[],
			  double *F, int *stat, bool vderiv[]);
