import numpy as np 
import random
import matplotlib.pyplot as plt
import time as tm
import scipy.io as scio


# 计算数据点到各个聚类中心的距离
# 返回距离矩阵
def center_dis(data,centers):
    dis=[]
    for i,d in zip(range(len(data)),data):
        dis.append([])
        for c in centers:
            dis[i].append(np.linalg.norm(d-c))
    return np.array(dis)

# 根据距离更新聚类
# 返回新的聚类划分
def update_clusters(dis):
    new_clusters=[]
    for d in dis:
        d=list(d)
        new_clusters.append(d.index(min(d)))
    return np.array(new_clusters)

# 重新计算聚类的重心并用中心替换中心点
# 返回新的中心点
def update_centers(data,new_clusters,num):
    cluster_members=[[] for _ in range(num)]
    for i,d in zip(new_clusters,data):
        cluster_members[i].append(d)
    new_centers=[np.mean(members,axis=0) for members in cluster_members]
    return new_centers

# 计算新得到的聚类中心是否与上次相同（实际上是足够接近）
# 返回是否结束迭代
def Is_identical(centers,new_centers):
    eps=1e-4
    diff=0
    for i,j in zip(centers,new_centers):
        diff+=np.linalg.norm(i-j)
    if diff<eps:
        return True
    else:
        return False

# 计算目标函数的值
# 返回代价函数的值
def get_error(data,new_clusters,centers):
    err=0
    for i,d in zip(new_clusters,data):
        err+=np.linalg.norm(d-centers[i])
    err/=len(data)
    return err

# 数据可视化
def plot_clusters(data,new_clusters,num):
    colors=['blue','green','red','orange','yellow','purple','brown']
    for i in range(num):
        color=colors[i]
        x=[]
        y=[]
        for j in range(len(data)):
            if new_clusters[j]==i:
                x.append(data[j,0])
                y.append(data[j,1])
        plt.scatter(x,y,c=color,alpha=1,marker='x')
    plt.title('K = %d' % num)
    plt.show()


def kmeans_clustering(data, num):

    # 确定初始中心点
    # 随机选取
    centers=[]
    for i in range(num):
        centers.append(data[random.randint(0,len(data))])
        # print(centers[i])
    
    # 迭代次数
    cnt=0
    while 1:
        cnt+=1
        # 计算与聚类中心的距离
        dis=center_dis(data,centers)
        # 重新划分聚类
        new_clusters=update_clusters(dis)
        # 更新聚类中心
        new_centers=update_centers(data,new_clusters,num)
        # 判断是否停止
        if Is_identical(centers,new_centers):
            centers=new_centers
            err=get_error(data,new_clusters,centers)
            break
        else:
            centers=new_centers
    return [round(err,3), new_clusters]

def kmeans_clustering_for_timing(data, num):

    # 确定初始中心点
    # 选取前num个点
    centers=[]
    # volume=int(len(data)/num)
    for i in range(num):
        # centers.append(data[i*volume])
        centers.append(data[i])
        # print(centers[i])
    
    # 迭代次数
    cnt=0
    while 1:
        cnt+=1
        # 计算与聚类中心的距离
        dis=center_dis(data,centers)
        # 重新划分聚类
        new_clusters=update_clusters(dis)
        # 更新聚类中心
        new_centers=update_centers(data,new_clusters,num)
        # 判断是否停止
        if Is_identical(centers,new_centers):
            centers=new_centers
            err=get_error(data,new_clusters,centers)
            break
        else:
            centers=new_centers
    return [round(err,3), new_clusters]  

path='data.mat'
data=scio.loadmat(path)['data']


# 利用肘部法则确定聚类个数
min_num=2
max_num=8
# 代价函数值
y=[]
for i in range(min_num,max_num):
    [err, new_clusters]=kmeans_clustering(data,i)
    y.append(err)
x=range(min_num,max_num)
plt.rcParams['font.sans-serif'] = ['Microsoft YaHei']
plt.title('“肘部法则”代价函数值关于聚类个数变化曲线')
plt.xlabel('聚类个数')
plt.ylabel('代价函数值')
plt.plot(x,y,marker='*')
for a,b in zip(x,y):
    plt.text(a,b,b,ha='center',va='bottom')
plt.show()

[err, new_clusters]=kmeans_clustering(data,3)
plot_clusters(data,new_clusters,3)


packs=15
volume=int(len(data)/packs)
y=[]
for i in range(1,packs+1):
    tic=tm.time()
    # for j in range(1,6):
        # kmeans_clustering(data[0:i*volume-1],3)
    kmeans_clustering_for_timing(data[0:i*volume-1],3)
    toc=tm.time()
    y.append(round((toc-tic),3))
x=[i*volume for i in range(1,packs+1)]
plt.rcParams['font.sans-serif'] = ['Microsoft YaHei']
plt.title('相同初始中心点时耗时关于数据规模的变化曲线')
plt.xlabel('数据规模')
plt.ylabel('耗时/s')
plt.plot(x,y,marker='*')
for a,b in zip(x,y):
    plt.text(a,b,b,ha='center',va='bottom')
plt.show()