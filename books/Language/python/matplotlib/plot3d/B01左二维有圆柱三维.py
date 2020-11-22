import matplotlib.pyplot as plt
from matplotlib import cm
import numpy as np

ax = plt.axes([0.15, 0.10, 0.35, 0.80])
ax3 = plt.axes([0.5, -0.05, 0.6, 1.3], projection="3d")

# 圆柱半径
r = 1.0
# 圆柱长度
length = 5.0
# 圆柱圆周方向分段
ksi_number = 500
# 圆柱轴向分段 注意 Y 方向是圆柱轴向
z_number = 500

# 二维
if True:
    ax.spines["bottom"].set_position(("data", 0))
    ax.spines["left"].set_position(("data", 0))
    ax.spines["right"].set_color("none")
    ax.spines["top"].set_color("none")

    ax.set_xlim(-2 * 2 * np.pi, 2 * 2 * np.pi)
    ax.set_ylim(-4, 4)

if True:
    # 定义三维数据
    ksi_steps = np.linspace(0, 2 * np.pi, ksi_number)
    # 圆柱数据
    xx = r * np.cos(ksi_steps)
    zz = r * np.sin(ksi_steps)
    yy = np.linspace(0, length, z_number)
    X, Y = np.meshgrid(xx, yy)
    Z, _ = np.meshgrid(zz, yy)

    # 圆柱作图
    ax3.plot_surface(X, Y, Z, color="blue", alpha=0.1)
    ax3.plot_wireframe(X, Y, Z, rstride=100, cstride=125, color="grey", alpha=0.1)

    # 扩大图形范围，让圆柱长一点
    ax3.plot3D(-2, 0, -2)
    ax3.plot3D(2, 0, 2)

    # 坐标
    ax3.plot3D([0, 2], [0, 0], [0, 0], color="k", lw=0.8)
    ax3.plot3D([0, 0], [0, 0], [0, 2], color="k", lw=0.8)
    ax3.plot3D([0, 0], [0, 8], [0, 0], color="k", lw=0.8)

    plt.axis("off")
    ax3.w_xaxis.set_pane_color((1.0, 1.0, 1.0, 1.0))


plt.show()