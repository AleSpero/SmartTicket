package com.sperolabs.smartticket.home

interface HomeContract {

    interface View {

        fun refreshList()

        fun refreshBottomAppBar()

        fun swapToScan()


    }

    interface Presenter {

        fun getShoppingList()

    }

}