import math
import sys
import matplotlib
import matplotlib.pyplot as plt
from scipy import stats as scistats

def readFile(pathToFile):
  data = {'labels': [], 'data': []}
  with open(str(pathToFile)) as f:
    lines = f.read().splitlines()
    for line in lines:
      lineAsList = line.split()
      benchmark = str(lineAsList[0])
      speedup = float(lineAsList[1])
      data['labels'].append(benchmark)
      data['data'].append(speedup)
    f.close()

  return data

def getArgs():
  args = {}
  numOfArgs = 1

  lenArgv = len(sys.argv)
  if (lenArgv < numOfArgs + 1):
    print('USAGE: $ python ' + sys.argv[0] + ' path/to/file.txt')
    sys.exit(1)

  args['pathToFile'] = sys.argv[1]

  return args

args = getArgs()
data = readFile(args['pathToFile'])

dataToPlot = data['data']
dataToPlot.append(scistats.mstats.gmean(dataToPlot))

labels = data['labels']
labels.append('geo. mean')

fig = plt.figure()
ax = fig.add_subplot(111)

fontSize = 12

matplotlib.rcParams.update({'font.size': fontSize})
ax.set_ylabel('Speedup', fontsize = fontSize)

barWidth = 0.4
xTicks = range(len(labels))
ax.bar(xTicks, dataToPlot, barWidth, color = 'black')

ymin = 0
ymax = math.ceil(max(dataToPlot))
ystep = 1

plt.xticks(xTicks, labels, fontsize = fontSize, rotation = 60, ha = 'right')
plt.yticks(range(ymin, ymax + 1, ystep), fontsize = fontSize)

xmin = xTicks[0]
xmax = xTicks[-1]

gap = 0.5

ax.set_ylim(ymin = ymin, ymax = ymax + gap)
ax.set_xlim(xmin = xmin - gap, xmax = xmax + gap)

# Lines
lineWidth = 2.5
ax.plot([xmin - gap, xmax + gap], [ymax, ymax], '--', color = 'red', linewidth = lineWidth)

geomeanx = ((xTicks[-1] - xTicks[-2])/2.0) + xTicks[-2]
ax.plot([geomeanx, geomeanx], [ymin, ymax + gap], '--', color = 'k', linewidth = lineWidth)

ax.plot([xmin - gap, xmax + gap], [1.0, 1.0], '--', color = 'gray', linewidth = lineWidth)

# Annotations
fontSizeAnnotation = 11
ax.annotate('Hardware cores', fontsize=fontSizeAnnotation, xy=(13, 11.3), color = 'red', bbox = dict(ec='none', fc = 'none', alpha = 1))

ax.yaxis.grid(True, color = 'gray', ls = '--')
ax.set_axisbelow(True)

ax.tick_params(axis = 'x', direction = 'out', top = False)

#ax.legend(fontsize = fontSize, fancybox = False, framealpha = 1, ncol = len(legend), loc = 'upper left') # handletextpad = 0.5, columnspacing = 1.1, bbox_to_anchor = (1.0, 1.03), bbox_transform = ax.transAxes

matplotlib.rcParams['pdf.fonttype'] = 42
matplotlib.rcParams['ps.fonttype'] = 42

#ax.set_aspect(0.02)

plt.tight_layout()
plt.savefig('./barplot.pdf', format = 'pdf')
#plt.show()
