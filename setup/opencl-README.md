<div align="center">

# High-Performance Histogram Equalisation with OpenCL

[![C++](https://img.shields.io/badge/C++-00599C?style=for-the-badge&logo=cplusplus&logoColor=white)](https://isocpp.org)
[![OpenCL](https://img.shields.io/badge/OpenCL-ED1C24?style=for-the-badge&logo=khronos&logoColor=white)](https://www.khronos.org/opencl/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)](LICENSE)

> GPU-accelerated histogram equalisation for grayscale and colour images using OpenCL — with 16-bit input support, local memory optimisation, variable bin sizes, and statistical analysis output.

</div>

---

## Overview

Histogram equalisation is a fundamental image enhancement technique, but naive CPU implementations become a bottleneck at scale. This project implements the algorithm on the GPU using **OpenCL**, exploiting parallel hardware to process images significantly faster than sequential C++ while remaining portable across GPU vendors (NVIDIA, AMD, Intel).

The implementation goes beyond a basic port — it uses **local (shared) memory** to minimise global memory latency, supports **variable bin sizes** for fine-grained control, processes both grayscale and multi-channel colour images, and outputs statistical metrics (entropy, variance) alongside the equalised result.

---

## Architecture

```
┌──────────────────────────────────────────────────────────────┐
│                      Host (C++)                              │
│  Image I/O → Platform query → Buffer alloc → Kernel dispatch │
│  Reads 8-bit or 16-bit input (PNG/BMP/PGM)                   │
└──────────────────────┬───────────────────────────────────────┘
                       │  cl::Buffer transfer (host → device)
┌──────────────────────▼───────────────────────────────────────┐
│                   OpenCL Device (GPU)                        │
│                                                              │
│  Kernel 1: histogram_local                                   │
│   Each work-group builds a partial histogram in local mem    │
│   Atomic adds merge partial histograms into global result    │
│                                                              │
│  Kernel 2: prefix_sum (scan)                                 │
│   Parallel prefix sum to compute CDF from histogram          │
│                                                              │
│  Kernel 3: equalise                                          │
│   Apply LUT derived from CDF to remap pixel intensities      │
└──────────────────────┬───────────────────────────────────────┘
                       │  cl::Buffer transfer (device → host)
┌──────────────────────▼───────────────────────────────────────┐
│                    Output Layer (C++)                        │
│  Equalised image write · Entropy/variance computation · GUI  │
└──────────────────────────────────────────────────────────────┘
```

---

## Key Features

- **GPU-parallel histogram computation** — work-groups accumulate partial histograms in fast local memory, then merge with atomic operations into a global result
- **Parallel prefix sum** — CDF computation is parallelised using a GPU scan kernel rather than a sequential CPU loop
- **16-bit image support** — handles high bit-depth input common in medical imaging and scientific photography
- **Variable bin sizes** — the number of histogram bins is configurable at runtime, allowing precision vs. performance trade-offs
- **Colour image support** — processes each channel independently, then recombines, or operates in luminance space to preserve colour fidelity
- **Statistical output** — computes entropy and variance of the input and output histograms to quantify the enhancement
- **Interactive GUI** — view the original, equalised, and histogram overlay side-by-side

---

## Tech Stack

| Component | Technology |
|---|---|
| Language | C++17 |
| GPU Computing | OpenCL 1.2+ |
| OpenCL C++ Wrapper | cl.hpp / cl2.hpp |
| Image I/O | stb_image / OpenCV |
| GUI | Qt / OpenGL |
| Build System | CMake |

---

## Getting Started

### Prerequisites

- An OpenCL 1.2+ capable GPU (NVIDIA, AMD, or Intel)
- OpenCL SDK / runtime drivers installed
- CMake 3.14+, C++17 compiler

```bash
# Clone the repo
git clone https://github.com/Ghost-tech-ng/Optimized-Histogram-Equalisation-with-OpenCL-for-Grayscale-and-Color-Images.git
cd Optimized-Histogram-Equalisation-with-OpenCL-for-Grayscale-and-Color-Images

# Build
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j$(nproc)

# Run on an image
./hist_eq --input ../images/sample.png --bins 256 --output output.png
```

---

## Performance

GPU parallelism provides substantial throughput gains over sequential CPU processing, particularly for large images or batch workloads. The local memory optimisation reduces global memory bandwidth requirements by allowing each work-group to operate on a private histogram segment before synchronising.

---

## Key Concepts Demonstrated

- OpenCL host/device programming model
- Work-group local memory and synchronisation barriers
- Atomic operations for parallel histogram accumulation
- GPU-parallel prefix sum (scan) algorithms
- Cross-vendor GPU portability

---

## Author

**Eghosa Osemwegie** — [GitHub](https://github.com/Ghost-tech-ng) · [Portfolio](http://www.eghosa.tech) · [Email](mailto:osemwegiee@gmail.com)
