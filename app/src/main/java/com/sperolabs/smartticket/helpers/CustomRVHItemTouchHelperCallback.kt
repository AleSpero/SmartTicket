package com.sperolabs.smartticket.helpers

import android.content.Context
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Rect
import android.graphics.drawable.ColorDrawable
import android.graphics.drawable.Drawable
import androidx.recyclerview.widget.ItemTouchHelper
import androidx.recyclerview.widget.RecyclerView
import com.sperolabs.smartticket.R
import github.nisrulz.recyclerviewhelper.RVHAdapter
import github.nisrulz.recyclerviewhelper.RVHItemTouchHelperCallback

/**
 * Created by alessandros on 04/11/2018.
 * @author Alessandro Sperotti
 */
class CustomRVHItemTouchHelperCallback(adapter: RVHAdapter,
                                       isLongPressEnabled: Boolean,
                                       isItemViewSwipeEnabledLeft: Boolean,
                                       isItemViewSwipeEnabledRight: Boolean,
                                       val context: Context) : RVHItemTouchHelperCallback(adapter, isLongPressEnabled, isItemViewSwipeEnabledLeft, isItemViewSwipeEnabledRight) {

    private var deleteIcon: Drawable? = null
    private var intrinsicWidth: Int = 0
    private var intrinsicHeight: Int = 0
    private val background = ColorDrawable()
    private val backgroundColor = Color.parseColor("#e53935")


    override fun onChildDraw(c: Canvas, recyclerView: RecyclerView, viewHolder: RecyclerView.ViewHolder, dX: Float, dY: Float, actionState: Int, isCurrentlyActive: Boolean) {

       if(actionState == ItemTouchHelper.ACTION_STATE_SWIPE){
           val itemView = viewHolder.itemView
           val itemHeight = itemView.bottom - itemView.top

           deleteIcon = context.getDrawable(R.drawable.ic_delete)
           intrinsicHeight = deleteIcon!!.intrinsicHeight
           intrinsicWidth = deleteIcon!!.intrinsicWidth

           background.color = backgroundColor
           background.bounds = Rect(itemView.right + dX.toInt(),
                   itemView.top,
                   itemView.right,
                   itemView.bottom)

           background.draw(c)

           // Calculate position of delete icon
           val iconTop = itemView.top + (itemHeight - intrinsicHeight) / 2
           val iconMargin = (itemHeight - intrinsicHeight) / 2
           val iconLeft = itemView.right - iconMargin - intrinsicWidth
           val iconRight = itemView.right - iconMargin
           val iconBottom = iconTop + intrinsicHeight

           // Draw the delete icon
           deleteIcon!!.setBounds(iconLeft, iconTop, iconRight, iconBottom)
           deleteIcon!!.draw(c)

       }

        super.onChildDraw(c, recyclerView, viewHolder, dX, dY, actionState, isCurrentlyActive)
    }

}