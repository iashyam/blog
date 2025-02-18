---
layout: post
title: "Heat Equation using Spectral Method"
date: 2024-12-15
categories: [Code, Physics]
tags: [Article, physics]
math: true
---

```python
import matplotlib.pyplot as plt
import numpy as np
from numpy import pi
from scipy import fft

plt.style.use('seaborn-v0_8-whitegrid')
```

# Solving heat equation using spectral methods

Our heat equation is this:

\begin{equation}
\frac{\partial u}{\partial t} = \kappa \nabla^2 u
\end{equation}

We will slove this equation in a square box of legth $L$ first. 

To start solving this equation, we will first have to non-dimenssionalise it. Because computers don't understand the language of units. We need to find the natural length scale which can be easily identified as the length of the rod $L$. Now we define dimenssionless position as $x \to \frac{x}{L}$. Then we need to find the scale for time. If we put the length scale into the equation, we will find that the time scale is $\tau = \frac{L^2}{\kappa}$. Then we define $t \to \frac{t}{\tau}$. We also need to find a temperature scale, which doesn't effect our equation because it is on both side and will cancel out. But still we need to do that. The natural temperature scale is found in the intial  intial distribution of the temperature. Then this $T_0$ can we taken as temperature scale and the dimenssionless temperature would be $T \to T/T_0$. Not that our space domain reduces to just $[0,1]$ in dimenssionless variables. Now we easily write the diffrential equation in dimenssionless variables:

Then our equation becomes 

\begin{equation}
\frac{\partial u}{\partial t} = \nabla^2 u
\end{equation}

To solve this equation, we will take spatial fourier transform on both side of the equation and then the $\nabla$ operator becomes just $-k^2$. So our equation has this form now

\begin{equation}
\frac{\partial \hat{u}}{\partial t} = -k^2 \hat{u}
\end{equation}

Then we can use any kind of integrator to solve this temporal equation, for the simplicity, we will use the Euler's method now, then we can imporve it by using Runge Kutta and other fancy method later. The equation at a later time will look like this"

\begin{equation}
\hat{u}(t+\Delta t) = \hat{u} + \Delta t (-k^2 \hat{u})
\end{equation}

Then we can take inverse fourier tranform to get back to the $u$ at that instant of time. 

Now we need boundary conditions, we will take simple boundary conditions as usual to model. 
The intial temeperature destribution is given by:

$$u(r, 0) =  e^{-r^2}$$

At the edges, the temperature is 0. The boundary conditions are the periodic boundary conditions. 

Now we start solving the equation


```python
%matplotlib inline

t0 = 0 #intial time
tf = 50 #final time
dt = 1e-2 #time step

Nt = int((tf-t0)/dt) #total number of time steps

Nx = 32 #total number of spatial grid steps
h = 1/Nx #the grid spacing

xs = np.linspace(0,1, Nx)

#making the intial temperature matrix
U = np.zeros((Nx, Nx, Nt), dtype='float64')


def To(x, y):

    return np.exp(-(x-0.5)**2 - (y-0.5)**2)
    # return 2*np.sin(x*np.pi*3)**2 + 3*np.cos(y*np.pi*3)**2
    # return np.random.uniform(0,1)
    # return 0

for i in range(Nx):
    for j in range(Nx):
        x = i*h
        y = j*h
        U[i,j,0] =  To(x,y)
        
```


```python
plt.pcolormesh(U[:,:,0], cmap='rainbow', vmin=0, vmax=1)
plt.colorbar()
plt.show()
```


    
![png](/assets/Heat Equation using Spectral Method-1.png)
    



```python
#applyting spectral method
for i in range(1,Nt):
    u = U[:, :, i-1]

    u_hat = fft.fft2(u) #taking the fourier transform

    k_x = fft.fftfreq(Nx)*(2*pi/1)
    k_y = fft.fftfreq(Nx)*(2*pi/1)
    kx, ky = np.meshgrid(k_x,k_y)
    
    k_spec = kx*kx + ky*ky

    u_hat += -k_spec*u_hat*dt

    #taking the inverse fourier tranform
    u_real = np.real(fft.ifft2(u_hat))


    U[:,:,i] = u_real

```


```python
plt.pcolormesh(U[:,:,60], cmap='rainbow')
plt.show()
```


    
![png](/assets/Heat Equation using Spectral Method-2.png)
    



```python
%matplotlib qt
for i in range(Nt):
    if i%10==0:
        plt.clf()
        plt.pcolormesh(U[:,:,i], cmap='rainbow', vmin=0, vmax=(1))
        plt.title(f't = {round(i*dt)}')
        plt.pause(0.1)
```

Taking a rondom point and seeing it's behaviour with time


```python
x = np.random.choice(range(Nx))
y = np.random.choice(range(Nx))

temp_point = U[x, y, :]
plt.plot(temp_point)
```




    [<matplotlib.lines.Line2D at 0x7f005038b970>]




    
![png](/assets/Heat Equation using Spectral Method-3.png)
    


trying psudo spectral method

### Numerical solutions from pseudo-spectral methods with filtering

The above process works very fine, and gives us the accurate results for periodic boundary conditions. However sometimes, we have an insight in the equation, which can help us to reduce the eqation in simpler form. It also reduces the computation time and power required. We would have to find a perticular thing called the integrating factor. And from thereon, we can work on this onwards.

In Fourier space, these equations are of the form

$$
\dot{\phi_q} = \alpha(q) \phi_q + \hat{N}_q 
$$

Multiplying both sides by $\exp(−\alpha(k)t)$ gives

$$
\frac{d(\phi_q e^{-\alpha t}) }{dt} =\frac{d \psi }{dt}=  e^{-\alpha t}\hat{N}_q  
%+ e^{-\alpha t}i\mathbf q \cdot \mathbf \Lambda
$$

Thus, we can solve for $\psi_q=\phi_q e^{-\alpha t}$ and then compute 

$$\phi_q (t+dt) = \psi_q (t+dt)e^{\alpha (t+dt)} = \left[\psi_q (t) + dt \left(e^{-\alpha t}
\hat{N}_q \right)\right] e^{\alpha (t+dt)}
$$

This can be simplified to
$$\phi_q (t+dt) = \left[\phi_q (t) + dt\hat{N}_q   \right] e^{\alpha dt}
$$

The heat equation is a very simple equation, It has no non-linear terms and we could easily solve this for time part analytically. 
The equation right now is

\begin{equation}
\frac{\partial u}{\partial t} = \nabla^2 u
\end{equation}

After taking the fourier transform it becomes

\begin{equation}
\frac{\partial \hat{u}}{\partial t} = -k^2 \hat{u}
\end{equation}

Now we multiply by $e^{k^2 t}$ both side and do some rearrangement then the equation becomes

\begin{equation}
\frac{\partial \hat{u}}{\partial t}e^{k^2 t}  -k^2 \hat{u} e^{k^2 t} = 0
\end{equation}

which is precisely 
\begin{equation}
\frac{\partial }{\partial t}(\hat{u} e^{k^2 t}) = 0
\end{equation}

We integate this equation from $t=0$ to $t=t$ and find the solution of the form

$$\hat{u}(t) =  \hat{u}(0)e^{-k^2 t}$$

Now we take fourier inverse transfrom and find our solutions as expected:

$${u}(t) =  \mathcal{F}^{-1}(\hat{u}(0)e^{-k^2 t})$$

The implimentation of this code is given below.


```python
u0 = U[:, :, 0]
k_x = fft.fftfreq(Nx)*(2*pi/1)
k_y = fft.fftfreq(Nx)*(2*pi/1)
kx, ky = np.meshgrid(k_x,k_y)

ksq = kx*kx + ky*ky
#taking the fourier transform
uhat = fft.fft2(u0)

for i in range(1, Nt):
    
    #current time is just how much steps we have taken
    t = i*dt

    U[:, :, i] = np.real(fft.ifft2(uhat*np.exp(-ksq*t)))

```


```python
%matplotlib qt
for i in range(Nt):
    if i%10==0:
        plt.clf()
        plt.pcolormesh(U[:,:,i], cmap='rainbow', vmin=0, vmax=(1))
        plt.title(f't = {round(i*dt)}')
        plt.colorbar()
        plt.pause(0.1)
```


```python

```
