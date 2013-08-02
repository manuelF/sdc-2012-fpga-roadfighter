import pygame
import math

width = 640
height = 400

screen = pygame.display.set_mode((width,height))
clock = pygame.time.Clock()
running = True

STREAM_CENTER = 200
STREAM_OSC = 30
STREAM_WIDTH = 90
STREAM_LENGTH = 512
FREQ = (2.0*math.pi)/STREAM_LENGTH
BLUE = (0,0,255)

offset_table = {}
def fill_offset_table():
	for x in xrange(0,STREAM_LENGTH):
		off = int(round(STREAM_OSC*math.sin(FREQ*x)))
		offset_table[x] = STREAM_OSC + off

def blue_pixel_range(y):
	start_off = offset_table[y % STREAM_LENGTH]
	mid = STREAM_CENTER - STREAM_OSC + start_off
	return xrange(mid,mid+STREAM_WIDTH)
	
def write_offset():
	with open("river_offsets.coe","w") as f:  
		f.write("memory_initialization_radix=10;\nmemory_initialization_vector=\n")
		for x in xrange(0,STREAM_LENGTH):
			val = offset_table[x]
			f.write("%d,\n" % val)
	
if __name__ == '__main__':
	fill_offset_table()
	for y in xrange(0,height):
		for x in blue_pixel_range(y):
			screen.set_at((x,y),BLUE)
			
	while running:	
		for event in pygame.event.get():
			if event.type == pygame.QUIT:
				running = False
				
		pygame.display.flip()
		clock.tick(240)
	
	write_offset()